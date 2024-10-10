/*
  Warnings:

  - A unique constraint covering the columns `[materialId]` on the table `Order_spk` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `materialId` to the `Order_spk` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Order_spk" ADD COLUMN     "materialId" INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Order_spk_materialId_key" ON "Order_spk"("materialId");

-- AddForeignKey
ALTER TABLE "Order_spk" ADD CONSTRAINT "Order_spk_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "Material"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
