const express =
require("express");

const router =
express.Router();

const {
 getProfile
} =
require(
 "../controllers/userController"
);

router.get(
 "/:uid",
 getProfile
);

module.exports =
router;