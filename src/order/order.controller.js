const express = require ("express");
const router = express.Router();
const orderService = require("./order.service");
const { getMaterialById } = require("../material/material.service");

router.post("/order", async (req, res) => {
    try {
        const {userId, materialId, orderQty} = req.body
        const newOrder = await orderService.orderMaterial(userId, materialId, orderQty);
        res.status(201).json(newOrder);
    } catch (error) {
        res.status(400).send(error.message);
        
    } 
})

router.get("/", async (req, res) => {
    try {
        const order = await orderService.getAllOrder();
        res.send(order) 
    } catch (error) {
        res.status(500).send(error.message)   
    }  
});

router.get("/user", async (req, res) => {
    const {userId} = req.body;
    try {
        const order = await orderService.getOrderByUserId(userId);
        res.status(200).send(order)
    } catch (error) {
        res.status(500).send(error.message)  
    }
})

router.get("/:id", async (req, res) => {
    try {
        const orderId = req.params.id
        const order = await getOrderById(orderId)
        res.status(200).send(order)
    } catch (error) {
        res.status(400).send(error.message)   
    } 
})

router.patch("/verify/:orderId", async (req, res) => {
    try {
        const { orderId } = req.params;
        const {status} = req.body
        await orderService.verifyOrder(orderId, status)
        res.status(200).json({message : "Order Successfully"})
    } catch (error) {
        res.status(400).send(error.message)
        
    }
    
})
module.exports = router;