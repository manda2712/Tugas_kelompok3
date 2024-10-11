const { Prisma } = require("@prisma/client")
const orderRepository = require("./order.repository")
const materialRepository = require("../material/material.repository")


async function orderMaterial(userId, materialId, orderQty) {
    const newOrder = await orderRepository.createOrder(userId, materialId, orderQty)
    return newOrder    
}

async function getAllOrder() {
    const order = await orderRepository.findOrder()
    return order   
}

async function getOrderByUserId(userId) {
    const order = await orderRepository.findOrderByUserId(userId)
    return order  
}

async function getOrderById(orderId) {
    const order = await orderRepository.findOrderById(orderId);
    return order   
}

async function verifyOrder(orderId, ) {
    const order = await orderRepository.findOrderById(orderId)
    if(!order){
        throw new Error("Order Not Found");
    }  
}

async function verifyOrder(orderId, status) {
    const order = await orderRepository.findOrderById(orderId)
    return order;   
}

async function verifyOrder(orderId, status) {
    const order = await orderRepository.findOrderById(orderId)
    if (!order) {
        throw new Error("Transaction Not Found");   
    }
    await orderRepository.updateOrderStatus(orderId, status, status === "DONE" ?  "upadatedAt" : new Date() )

    if(status === "DONE"){
        const material = await materialRepository.findMaterialsById(order.materialId)
        if(!material){
            throw new Error("item not found");
        }
        const newStock = material.stock - order.orderQty
        if (newStock < 0) {
            throw new Error("cannot order");   
        }
        await materialRepository.updatematerial(material.id, newStock)
    }
    
}

module.exports ={
    orderMaterial,
    getAllOrder,
    getOrderById,
    getOrderByUserId,
    verifyOrder
}