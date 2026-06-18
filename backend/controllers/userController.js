const { db } =
require("../config/firebase");

exports.getProfile =
async(req,res)=>{

 try{

  const uid =
  req.params.uid;

  const user =
  await db
  .collection("users")
  .doc(uid)
  .get();

  res.json(
   user.data()
  );

 }catch(error){

  res.status(500).json({
   error:error.message
  });

 }

};