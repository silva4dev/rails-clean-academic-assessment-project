import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { makeHttpGetHistoriesService, makeHttpGetStudentGradesService } from "../../application/factories";
import { HistoryEntity } from "../../domain/entities";

const StudentPage: React.FC = () => {
  const [histories, setHistories] = useState<HistoryEntity[]>([]);
  const [grades, setGrades] = useState<any>([]);
  const { id } = useParams();
  const navigate = useNavigate();

  useEffect(() => {
    const fetchHistories = async () => {
      const response = await makeHttpGetHistoriesService(`${id}`).execute(null);
      if (response?.value) {
        setHistories(response.value.data);
      }
    };
    const fetchGrades = async () => {
      const response = await makeHttpGetStudentGradesService(`${id}`).execute(null);
      if (response?.value) {
        setGrades(response.value.data);
      }
    };
    fetchHistories();
    fetchGrades();
  }, []);

  return (
    <div className="max-w-4xl mx-auto mt-10 p-6 bg-white rounded-lg shadow-lg">
      <button
        onClick={() => navigate("/")}
        className="mb-6 p-2 w-28 text-black border border-blue-400 bg-white rounded-md hover:bg-blue-600 hover:text-white"
      >
        Voltar
      </button>
      <h2 className="text-3xl font-semibold text-center mb-8">Histories</h2>
      {histories.length > 0 ? (
        <div className="overflow-x-auto bg-gray-50 rounded-lg shadow-sm">
          <table className="table-auto w-full text-sm text-gray-700">
            <thead className="bg-blue-600 text-white">
              <tr>
                <th className="px-6 py-3 text-left">Name</th>
                <th className="px-6 py-3 text-left">Final Grade</th>
                <th className="px-6 py-3 text-left">Reference Date</th>
              </tr>
            </thead>
            <tbody>
              {histories.map((history) => (
                <tr key={history.id} className="border-b border-gray-200 hover:bg-indigo-50">
                  <td className="px-6 py-4">{history.student.name}</td>
                  <td className="px-6 py-4">{history.final_grade}</td>
                  <td className="px-6 py-4">{new Date(history.reference_date).toLocaleDateString("pt-BR")}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : (
        <div className="text-center text-gray-600 mt-6">No histories found!</div>
      )}

      <h2 className="text-3xl font-semibold text-center mt-8 mb-4">Grades</h2>
      {grades?.grades && grades.grades.length > 0 ? (
        <div className="overflow-x-auto bg-gray-50 rounded-lg shadow-sm">
          <table className="table-auto w-full text-sm text-gray-700">
            <thead className="bg-blue-600 text-white">
              <tr>
                <th className="px-6 py-3 text-left">Discipline</th>
                <th className="px-6 py-3 text-left">Grade</th>
              </tr>
            </thead>
            <tbody>
              {grades.grades.map((grade: any) => (
                <tr key={grade.id} className="border-b border-gray-200 hover:bg-indigo-50">
                  <td className="px-6 py-4">{grade.discipline.name}</td>
                  <td className="px-6 py-4">{grade.value}</td>
                </tr>
              ))}
            </tbody>
            <tfoot>
              {grades?.final_grade !== undefined && (
                <tr className="bg-blue-600 text-white">
                  <td className="px-6 py-3 text-left" colSpan={2}>
                    <span className="text-gray-300">Final Grade:</span> {grades.final_grade}
                  </td>
                </tr>
              )}
            </tfoot>
          </table>
        </div>
      ) : (
        <div className="text-center text-gray-600 mt-6">No grades found!</div>
      )}
    </div>
  );
};

export default StudentPage;
