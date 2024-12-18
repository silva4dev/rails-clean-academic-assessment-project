import React from 'react';
import { Outlet } from 'react-router-dom';
import Footer from '../components/footer';
import Navbar from "../components/navbar";

const DefaultLayout: React.FC = () => (
  <div className="flex flex-col min-h-screen">
    <Navbar />    
    <main className="flex-1 p-4">
      <Outlet />
    </main>
    <Footer />
  </div>
);

export default DefaultLayout;
