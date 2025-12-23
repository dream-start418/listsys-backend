#!/bin/bash
# Fix Prisma drift issues while preserving data

echo "🔍 Checking Prisma migration status..."
npx prisma migrate status

read -p "Do you want to mark existing migrations as applied? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📋 Available migrations:"
    ls prisma/migrations/ | grep -v lock.toml
    
    read -p "Enter migration name to mark as applied (or 'all' for all): " MIGRATION_NAME
    
    if [ "$MIGRATION_NAME" = "all" ]; then
        # Mark all migrations as applied
        for dir in prisma/migrations/*/; do
            if [ -d "$dir" ]; then
                NAME=$(basename "$dir")
                echo "Marking $NAME as applied..."
                npx prisma migrate resolve --applied "$NAME"
            fi
        done
    else
        echo "Marking $MIGRATION_NAME as applied..."
        npx prisma migrate resolve --applied "$MIGRATION_NAME"
    fi
    
    echo ""
    echo "✅ Checking status again..."
    npx prisma migrate status
    
    echo ""
    read -p "Generate Prisma Client? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🔨 Generating Prisma Client..."
        npx prisma generate
    fi
fi

echo ""
echo "✅ Done!"

