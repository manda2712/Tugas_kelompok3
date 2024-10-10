const express = require('express');
const app = express();
const dotenv = require('dotenv');

dotenv.config();

const PORT = process.env.PORT || 3000;  // Fallback to 3000 if undefined

app.use(express.json());

app.get("/", (req, res) => {
    res.send('Hello kelompok 3!');
});

const authController = require("./auth/auth.controller");
app.use("/api/auth", authController);

const userController = require("./user/user.controller");
app.use("/api/users", userController);

app.listen(PORT, () => {
    console.log(`App listening on port ` + PORT);
});
