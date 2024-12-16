import React from 'react';
import { Routes, Route } from 'react-router-dom';
import HomePage from '../pages/home';
import DefaultLayout from '../layouts/default';

const AppRoutes: React.FC = () => (
  <Routes>
    <Route element={<DefaultLayout />}>
      <Route path="/" element={<HomePage />} />
    </Route>
  </Routes>
);

export default AppRoutes;
