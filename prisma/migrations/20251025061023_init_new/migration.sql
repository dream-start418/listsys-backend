-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL DEFAULT '',
    "password" TEXT NOT NULL,
    "passwordResetToken" TEXT NOT NULL DEFAULT '',
    "role" INTEGER NOT NULL DEFAULT 0,
    "planId" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "contractId" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Client" (
    "id" SERIAL NOT NULL,
    "contractId" TEXT NOT NULL,
    "memo" TEXT NOT NULL DEFAULT '',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Request" (
    "id" SERIAL NOT NULL,
    "requestRandId" TEXT NOT NULL,
    "projectName" TEXT NOT NULL,
    "wishNum" INTEGER NOT NULL DEFAULT 0,
    "mainCondition" JSONB NOT NULL,
    "subCondition" JSONB NOT NULL,
    "areaSelection" JSONB NOT NULL,
    "areaMemo" TEXT NOT NULL,
    "completeState" INTEGER NOT NULL,
    "cancelState" INTEGER NOT NULL DEFAULT 0,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "requestAt" TIMESTAMP(3),
    "deliveryAt" TIMESTAMP(3),
    "filePath" TEXT DEFAULT '',
    "fileName" TEXT DEFAULT '',
    "listCount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RequestBlue" (
    "id" SERIAL NOT NULL,
    "requestRandId" TEXT NOT NULL,
    "projectName" TEXT NOT NULL,
    "wishNum" INTEGER NOT NULL DEFAULT 0,
    "tags" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "detailCondition" JSONB NOT NULL,
    "areaSelection" JSONB NOT NULL,
    "areaMemo" TEXT NOT NULL,
    "completeState" INTEGER NOT NULL,
    "cancelState" INTEGER NOT NULL DEFAULT 0,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "requestAt" TIMESTAMP(3),
    "deliveryAt" TIMESTAMP(3),
    "filePath" TEXT DEFAULT '',
    "fileName" TEXT DEFAULT '',
    "listCount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "RequestBlue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RequestYellow" (
    "id" SERIAL NOT NULL,
    "requestRandId" TEXT NOT NULL,
    "projectName" TEXT NOT NULL,
    "wishNum" INTEGER NOT NULL DEFAULT 0,
    "portalSite" TEXT NOT NULL,
    "areaSelection" JSONB NOT NULL,
    "areaMemo" TEXT NOT NULL,
    "completeState" INTEGER NOT NULL,
    "cancelState" INTEGER NOT NULL DEFAULT 0,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "requestAt" TIMESTAMP(3),
    "deliveryAt" TIMESTAMP(3),
    "filePath" TEXT DEFAULT '',
    "fileName" TEXT DEFAULT '',
    "listCount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "RequestYellow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RequestPink" (
    "id" SERIAL NOT NULL,
    "requestRandId" TEXT NOT NULL,
    "projectName" TEXT NOT NULL,
    "wishNum" INTEGER NOT NULL DEFAULT 0,
    "areaSelection" JSONB NOT NULL,
    "areaMemo" TEXT NOT NULL,
    "completeState" INTEGER NOT NULL,
    "cancelState" INTEGER NOT NULL DEFAULT 0,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "requestAt" TIMESTAMP(3),
    "deliveryAt" TIMESTAMP(3),
    "filePath" TEXT DEFAULT '',
    "fileName" TEXT DEFAULT '',
    "listCount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "RequestPink_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RequestRed" (
    "id" SERIAL NOT NULL,
    "requestRandId" TEXT NOT NULL,
    "projectName" TEXT NOT NULL,
    "wishNum" INTEGER NOT NULL DEFAULT 0,
    "workSelection" JSONB NOT NULL,
    "areaSelection" JSONB NOT NULL,
    "areaMemo" TEXT NOT NULL,
    "completeState" INTEGER NOT NULL,
    "cancelState" INTEGER NOT NULL DEFAULT 0,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "requestAt" TIMESTAMP(3),
    "deliveryAt" TIMESTAMP(3),
    "filePath" TEXT DEFAULT '',
    "fileName" TEXT DEFAULT '',
    "listCount" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "RequestRed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RedStoreItem" (
    "id" SERIAL NOT NULL,
    "company" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "postNum" TEXT NOT NULL,
    "fax" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RedStoreItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CostClient" (
    "id" SERIAL NOT NULL,
    "red_price" INTEGER NOT NULL,
    "blue_price" INTEGER NOT NULL,
    "green_price" INTEGER NOT NULL,
    "yellow_price" INTEGER NOT NULL,
    "pink_price" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "CostClient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChatworkClient" (
    "id" SERIAL NOT NULL,
    "room_id" TEXT NOT NULL,
    "chatwork_token" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "ChatworkClient_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NoMatchItem" (
    "id" SERIAL NOT NULL,
    "bigCategory" TEXT NOT NULL,
    "smallCategory" TEXT NOT NULL,
    "area" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "NoMatchItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_contractId_key" ON "User"("contractId");

-- CreateIndex
CREATE UNIQUE INDEX "Client_contractId_key" ON "Client"("contractId");

-- CreateIndex
CREATE UNIQUE INDEX "Request_requestRandId_key" ON "Request"("requestRandId");

-- CreateIndex
CREATE UNIQUE INDEX "RequestBlue_requestRandId_key" ON "RequestBlue"("requestRandId");

-- CreateIndex
CREATE UNIQUE INDEX "RequestYellow_requestRandId_key" ON "RequestYellow"("requestRandId");

-- CreateIndex
CREATE UNIQUE INDEX "RequestPink_requestRandId_key" ON "RequestPink"("requestRandId");

-- CreateIndex
CREATE UNIQUE INDEX "RequestRed_requestRandId_key" ON "RequestRed"("requestRandId");

-- CreateIndex
CREATE UNIQUE INDEX "CostClient_userId_key" ON "CostClient"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "ChatworkClient_userId_key" ON "ChatworkClient"("userId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_contractId_fkey" FOREIGN KEY ("contractId") REFERENCES "Client"("contractId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Request" ADD CONSTRAINT "Request_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequestBlue" ADD CONSTRAINT "RequestBlue_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequestYellow" ADD CONSTRAINT "RequestYellow_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequestPink" ADD CONSTRAINT "RequestPink_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequestRed" ADD CONSTRAINT "RequestRed_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CostClient" ADD CONSTRAINT "CostClient_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChatworkClient" ADD CONSTRAINT "ChatworkClient_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
