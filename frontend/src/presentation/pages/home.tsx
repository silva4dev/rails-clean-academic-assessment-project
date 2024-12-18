import React, { useEffect, useState } from "react";
import { makeHttpGetTopStudentsService } from "../../application/factories/http-get-top-students-service-factory";
import { HistoryEntity } from "../../domain/entities";
import Button from "../components/button";

const HomePage: React.FC = () => {
  const [topStudents, setTopStudents] = useState<HistoryEntity[]>([]);

  useEffect(() => {
    const fetchTopStudents = async () => {
      const response = await makeHttpGetTopStudentsService().execute(null);
      if (response?.value) {
        setTopStudents(response.value.data);
      }
    };
    fetchTopStudents();
  }, [topStudents]);

  return (
    <div className="max-w-3xl mx-auto mt-8 p-6 bg-gray-100 rounded-lg shadow-md">
      <h2 className="text-3xl font-semibold mb-6 text-center">🏆 Top Students</h2>
      {topStudents.length > 0 ? (
        <div className="bg-white shadow-lg rounded-lg p-6">
          <div className="max-h-96 overflow-y-auto">
            <ul className="divide-y divide-gray-200">
              {topStudents.map((history, index) => (
                <li
                  key={index}
                  className="flex items-center justify-between py-4 mb-3"
                >
                  <div>
                    <span className="block text-lg font-medium text-gray-800">
                      {history.student.name}
                    </span>
                    <span className="text-sm text-gray-500">
                      Final Grade: {history.final_grade}
                    </span>
                  </div>
                  <Button studentId={history.student.id} />
                </li>
              ))}
            </ul>
          </div>
        </div>
      ) : (
        <div className="text-center text-gray-500 mt-10">
          <p>No students found!</p>
        </div>
      )}
    </div>
  );
};

export default HomePage;
