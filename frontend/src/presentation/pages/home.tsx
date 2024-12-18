import React, { useEffect, useState } from "react";
import { makeHttpGetTopStudentsService } from "../../application/factories/http-get-top-students-service-factory";
import { HistoryEntity } from "../../domain/entities";
import Button from "../components/button";
import { makeHttpGetStudentMaxGradeService } from "../../application/factories/http-get-student-max-grade-service-factory";

const HomePage: React.FC = () => {
  const [topStudents, setTopStudents] = useState<HistoryEntity[]>([]);
  const [student, setStudent] = useState<any>(null);

  useEffect(() => {
    const fetchTopStudents = async () => {
      const response = await makeHttpGetTopStudentsService().execute(null);
      if (response?.value) {
        setTopStudents(response.value.data);
      }
    };
    const fetchGetMaxGradeStudent = async () => {
      const response = await makeHttpGetStudentMaxGradeService().execute(null);
      if(response?.value) {
        setStudent(response.value.data);
      }
    }
    fetchTopStudents();
    fetchGetMaxGradeStudent();
  }, []);

  return (
    <div className="max-w-3xl mx-auto mt-8 p-6 bg-gray-100 rounded-lg shadow-md">
      <h2 className="text-3xl font-semibold mb-6 text-center">🏆 Top Students</h2>
      {student ? (
        <div className="bg-white shadow-lg rounded-lg p-6 mb-6">
          <h3 className="text-2xl font-semibold text-center mb-4">🎯 Student Closest to Max Grade</h3>
          <div className="text-center">
            <p className="text-lg font-medium text-gray-800">{student.name}</p>
            <p className="text-sm text-gray-500">Final Grade: {student.final_grade}</p>
          </div>
        </div>
      ) : (
        <div className="text-center text-gray-500 mb-6">
           <p>No student found!</p>
        </div>
      )}
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
