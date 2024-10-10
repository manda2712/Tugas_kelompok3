const express = require ("express");
const router = express.Router();
const orderService = require("./order.service");

router.post("/order", async (req, res) => {
    try {
        const {userId, materialId, orderQty} = req.body
        const newOrder = await orderService.orderMaterial(userId, materialId, orderQty);
        res.status(201).json(newOrder);
    } catch (error) {
        res.status(400).send(error.message);
        
    } 
})

module.exports = router;