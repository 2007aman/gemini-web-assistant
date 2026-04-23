import {createContext}from "react";
import { products } from "../assets/assets";

export const shopcontext=createcontext();

const shopcontextprovider=createContext();

const shopscontextprovider=(props) =>{
 
    const currency=$;
    const delivery_fee=10;
    const value={
        products,currency,delivery_fee
    }
    return (
        <shopcontext.provider value={value}>
        {props.children}
        </shopcontext.provider>
    )
}