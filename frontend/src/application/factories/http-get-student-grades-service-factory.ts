import { GetStudentGradesService } from "../../domain/services";
import { makeApiUrl, makeAxiosHttpClient } from "../../shared_kernel";
import { HttpGetStudentGradesService } from "../services";

export const makeHttpGetStudentGradesService = (id: string): GetStudentGradesService =>
  new HttpGetStudentGradesService(makeApiUrl(`/api/v1/grades/students/${id}`), makeAxiosHttpClient())
