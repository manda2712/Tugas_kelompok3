/*
  Warnings:

  - You are about to drop the column `order_qty` on the `Order_spk` table. All the data in the column will be lost.
  - Added the required column `orderQty` to the `Order_spk` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Order_spk" DROP COLUMN "order_qty",
ADD COLUMN     "orderQty" INTEGER NOT NULL;
