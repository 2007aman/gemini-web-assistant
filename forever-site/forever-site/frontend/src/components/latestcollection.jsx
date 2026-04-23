import React,{useContext,useEffect,useState} from "react";
import {shopContext} from '../context/shopcontext'
import Title from './Title'

const latestcollection=() =>{
   const {products}=useContext(shopContext);
   const [latestproducts,setLatestProducts]=useState([]);

   useEffect(()=>{
      setLatestProducts(products.slice(0,10));
   },[])
   
 return(
    <div className="my-10">
      <div className="text-center py-8 text-3x1">
      
      <title text1={'LATEST'} text2={'COLLECTIONS'}/>
       <p className="w=3/4 m-auto text-xs sm:text-sm md:text-base text-gray-500">Lorem ipsum dolor sit amet consectetur, adipisicing elit. Fugiat fugit maxime soluta perferendis rerum? Doloremque quasi a suscipit aperiam culpa ad, expedita veniam asperiores ratione illo aliquid unde quibusdam rem.</p>
    </div>
    </div>
    )
 }

 export default latestcollection