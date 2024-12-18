import React from 'react';
import { Routes, Route } from 'react-router-dom';
import HomePage from '../pages/home';
import DefaultLayout from '../layouts/default';
import StudentPage from '../pages/student';

const AppRoutes: React.FC = () => (
  <Routes>
    <Route element={<DefaultLayout />}>
      <Route path="/" element={<HomePage />} />
      <Route path="/student/:id" element={<StudentPage />} />
    </Route>
  </Routes>
);

export default AppRoutes;
