const prisma = require("../db");

async function createOrder(userId, materialId, orderQty) {
    try {
        const newOrder = await prisma.order_spk.create({
            data: {
                userId,
                materialId,
                orderQty,
                status: "PENDING"
            }
        });
        return newOrder;
    } catch (error) {
        throw new Error("failed create order"); 
    }
    
}

async function findOrder() {
    try {
        const order = await prisma.order_spk.findMany({
            include:{
                material:{
                    select:{
                        name: true
                    }
                }
            }
        })
        return order
    } catch (error) {
        throw new Error("failed to fetch order");    
    } 
}

async function findOrderByUserId(userId) {
    try {
        const order = await prisma.order_spk.findMany({
            where: {
                userId: parseInt(userId)
            },
            include: {
                material:{
                    select:{
                        name : true
                    }
                }
            }
        })
        return order
    } catch (error) {
        throw new Error("failed to fetch order by user Id");  
    } 
}

async function findOrderById(id) {
    const order = await prisma.order_spk.findUnique({
        where:{
            id: parent(id)
        }
    })
    return order  
}

module.exports ={
    createOrder,
    findOrder,
    findOrderByUserId,
    findOrderById
}