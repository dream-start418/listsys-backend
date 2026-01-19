# Prisma Migration Troubleshooting Guide

## When "Drift Detected" Error Occurs

### What is "Drift"?
- Your database schema doesn't match your migration history
- This happens when migrations are applied to the database but not recorded in Prisma
- Or when the schema.prisma is modified but migrations aren't run

### ❌ NEVER DO THIS WITH LIVE DATA:
```bash
# This will DELETE ALL DATA!
npx prisma migrate reset
```

## ✅ Safe Solution: Mark Migrations as Applied

### Step 1: Check Current Status
```bash
cd /data/service/listsys-backend
npx prisma migrate status
```

### Step 2: Check Which Migrations Are Missing

If Prisma says migrations are missing from the database, but the database already has the changes:

```bash
# List your migrations
ls -la prisma/migrations/

# Mark each migration as applied (without running it)
npx prisma migrate resolve --applied <migration_name>
```

For example:
```bash
npx prisma migrate resolve --applied 20251025061023_init_new
```

### Step 3: Verify Everything is Synced
```bash
npx prisma migrate status
# Should show: "Database schema is up to date!"
```

### Step 4: Generate Prisma Client
```bash
npx prisma generate
```

## 🔄 For Future Schema Changes

### Making New Changes Safely

When you update `schema.prisma` and want to create a new migration:

```bash
# This will create a new migration file
npx prisma migrate dev --name describe_your_changes

# Example:
npx prisma migrate dev --name add_new_feature_field
```

This will:
1. Create a migration file in `prisma/migrations/`
2. Apply it to your database
3. Preserve all existing data
4. Update Prisma's migration history

## 📋 Quick Reference Commands

```bash
# Check migration status
npx prisma migrate status

# Mark migration as applied (when DB already has the changes)
npx prisma migrate resolve --applied <migration_name>

# Create a new migration (when schema.prisma changed)
npx prisma migrate dev --name <description>

# Apply pending migrations (production)
npx prisma migrate deploy

# Generate Prisma Client
npx prisma generate

# Format Prisma schema
npx prisma format

# Remove old migration from database (when not in local directory)
psql -U postgres -d listan -c "DELETE FROM _prisma_migrations WHERE migration_name = '<old_name>';"
```

## 🚨 Important Notes

1. **Always backup before migrations**:
   ```bash
   pg_dump -U postgres -d listan > backup_$(date +%Y%m%d_%H%M%S).sql
   ```

2. **If schema.prisma was modified externally** (like manually in database):
   - Use `prisma migrate resolve --applied` to sync the state
   - Do NOT use `prisma migrate reset` if you have data

3. **For production**: Use `prisma migrate deploy` (doesn't reset anything)

4. **For development**: Use `prisma migrate dev` (creates new migrations)

## 🔍 Diagnosing Drift

```bash
# See what Prisma thinks is different
npx prisma migrate dev --name test  # Will show drift details

# Check database tables manually
psql -U postgres -d listan -c "\d"
psql -U postgres -d listan -c "SELECT * FROM _prisma_migrations;"
```

## 📝 Common Scenarios

### Scenario 1: Migration Applied Outside Prisma
**Problem**: Database was migrated manually or from backup  
**Solution**: 
```bash
npx prisma migrate resolve --applied <migration_name>
```

### Scenario 2: Schema Changed Locally, Migrations Not Created
**Problem**: You edited schema.prisma but didn't run migrate dev  
**Solution**:
```bash
npx prisma migrate dev --name <description>
```

### Scenario 3: Working with Restored Database
**Problem**: Database has data but Prisma doesn't know about migrations  
**Solution**:
```bash
# First, mark existing migration as applied
npx prisma migrate resolve --applied <migration_name>

# Then you can create new migrations normally
npx prisma migrate dev --name <new_changes>
```

### Scenario 4: Old Migration in Database But Not in Local Directory
**Problem**: Error message "The following migration(s) are applied to the database but missing from the local migrations directory"  
**Symptoms**: Database has old migrations (like `20250505005152_init`) that your local code doesn't have

**Solution** - Remove old migration from database:
```bash
# 1. Check what migrations are in the database
psql -U postgres -d listan -c "SELECT * FROM _prisma_migrations ORDER BY started_at;"

# 2. Remove the old migration that's not in your local directory
psql -U postgres -d listan -c "DELETE FROM _prisma_migrations WHERE migration_name = '<old_migration_name>';"

# Example:
psql -U postgres -d listan -c "DELETE FROM _prisma_migrations WHERE migration_name = '20250505005152_init';"

# 3. Verify status
npx prisma migrate status
# Should show: "Database schema is up to date!"

# 4. Test it works
npx prisma migrate dev
# Should show: "Already in sync, no schema change or pending migration was found."
```

**Why this happens**: When database is restored from an old backup, it might have migration history from an older codebase that doesn't exist in your current `prisma/migrations/` directory.

