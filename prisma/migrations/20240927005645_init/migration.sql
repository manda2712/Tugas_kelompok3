-- CreateEnum
CREATE TYPE "Role" AS ENUM ('PH_OPERATOR', 'WH_OPERATOR');

-- CreateEnum
CREATE TYPE "MaterialStatus" AS ENUM ('OFF', 'FREE', 'ON_DUTY');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PENDING', 'ON_PROCESS', 'DONE');

-- CreateEnum
CREATE TYPE "WarehouseStatus" AS ENUM ('OFF', 'FREE', 'ON_DUTY');

-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('SENT', 'READ');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "jwt_token" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PHOperator" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "PHOperator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WHOperator" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "WHOperator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Material" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "status" "MaterialStatus" NOT NULL,
    "whOperatorId" INTEGER NOT NULL,

    CONSTRAINT "Material_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "status" "OrderStatus" NOT NULL,
    "warehouseStatus" "WarehouseStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "phOperatorId" INTEGER NOT NULL,
    "whOperatorId" INTEGER NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "message" TEXT NOT NULL,
    "status" "NotificationStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "phOperatorId" INTEGER NOT NULL,
    "whOperatorId" INTEGER NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "PHOperator_userId_key" ON "PHOperator"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "WHOperator_userId_key" ON "WHOperator"("userId");

-- AddForeignKey
ALTER TABLE "PHOperator" ADD CONSTRAINT "PHOperator_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WHOperator" ADD CONSTRAINT "WHOperator_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Material" ADD CONSTRAINT "Material_whOperatorId_fkey" FOREIGN KEY ("whOperatorId") REFERENCES "WHOperator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_phOperatorId_fkey" FOREIGN KEY ("phOperatorId") REFERENCES "PHOperator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_whOperatorId_fkey" FOREIGN KEY ("whOperatorId") REFERENCES "WHOperator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_phOperatorId_fkey" FOREIGN KEY ("phOperatorId") REFERENCES "PHOperator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_whOperatorId_fkey" FOREIGN KEY ("whOperatorId") REFERENCES "WHOperator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
