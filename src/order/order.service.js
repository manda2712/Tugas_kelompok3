const { Prisma } = require("@prisma/client")
const orderRepository = require("./order.repository")

async function orderMaterial(userId, materialId, orderQty) {
    const newOrder = await orderRepository.createOrder(userId, materialId, orderQty)
    return newOrder    
}

async function getAllOrder() {
    const order = await orderRepository.findOrder()
    return order   
}

async function getOrderByUserId(userId) {
    const order = await orderRepository.findOrderByUserId()
    return order  
}

module.exports ={
    orderMaterial
}