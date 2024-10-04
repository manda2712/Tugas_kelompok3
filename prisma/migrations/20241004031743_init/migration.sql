/*
  Warnings:

  - You are about to drop the column `status` on the `Material` table. All the data in the column will be lost.
  - You are about to drop the column `whOperatorId` on the `Material` table. All the data in the column will be lost.
  - You are about to drop the column `jwt_token` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Notification` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Order` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PHOperator` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WHOperator` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[username]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `description` to the `Material` table without a default value. This is not possible if the table is not empty.
  - Added the required column `stock` to the `Material` table without a default value. This is not possible if the table is not empty.
  - Added the required column `update_at` to the `Material` table without a default value. This is not possible if the table is not empty.
  - Added the required column `update_at` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Material" DROP CONSTRAINT "Material_whOperatorId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_phOperatorId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_whOperatorId_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_phOperatorId_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_whOperatorId_fkey";

-- DropForeignKey
ALTER TABLE "PHOperator" DROP CONSTRAINT "PHOperator_userId_fkey";

-- DropForeignKey
ALTER TABLE "WHOperator" DROP CONSTRAINT "WHOperator_userId_fkey";

-- AlterTable
ALTER TABLE "Material" DROP COLUMN "status",
DROP COLUMN "whOperatorId",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "description" TEXT NOT NULL,
ADD COLUMN     "stock" INTEGER NOT NULL,
ADD COLUMN     "update_at" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "jwt_token",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "update_at" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "role" SET DEFAULT 'WH_OPERATOR';

-- DropTable
DROP TABLE "Notification";

-- DropTable
DROP TABLE "Order";

-- DropTable
DROP TABLE "PHOperator";

-- DropTable
DROP TABLE "WHOperator";

-- DropEnum
DROP TYPE "MaterialStatus";

-- DropEnum
DROP TYPE "NotificationStatus";

-- DropEnum
DROP TYPE "WarehouseStatus";

-- CreateTable
CREATE TABLE "Order_spk" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "order_qty" INTEGER NOT NULL,
    "status" "OrderStatus" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Order_spk_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Order_spk_userId_key" ON "Order_spk"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- AddForeignKey
ALTER TABLE "Order_spk" ADD CONSTRAINT "Order_spk_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
