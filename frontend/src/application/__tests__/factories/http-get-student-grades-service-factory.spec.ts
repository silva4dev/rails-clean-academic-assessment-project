import { makeApiUrl, makeAxiosHttpClient } from "../../../shared_kernel";
import { makeHttpGetStudentGradesService } from "../../factories/http-get-student-grades-service-factory";
import { HttpGetStudentGradesService } from "../../services/http-get-student-grades-service";

jest.mock("axios");

jest.mock("../../../shared_kernel", () => ({
  makeApiUrl: jest.fn(),
  makeAxiosHttpClient: jest.fn(),
}));

describe("makeHttpGetStudentGradesService", () => {
  const mockApiUrl = "http://example.com/api/v1/grades/students/123";
  const mockHttpClient = { request: jest.fn() };
  const studentId = "123";

  beforeEach(() => {
    (makeApiUrl as jest.Mock).mockReturnValue(mockApiUrl);
    (makeAxiosHttpClient as jest.Mock).mockReturnValue(mockHttpClient);
  });

  it("should return an instance of HttpGetStudentGradesService", () => {
    const service = makeHttpGetStudentGradesService(studentId);
    expect(service).toBeInstanceOf(HttpGetStudentGradesService);
  });

  it("should call makeApiUrl with the correct argument", () => {
    makeHttpGetStudentGradesService(studentId);
    expect(makeApiUrl).toHaveBeenCalledWith(`/api/v1/grades/students/${studentId}`);
  });

  it("should call makeAxiosHttpClient", () => {
    makeHttpGetStudentGradesService(studentId);
    expect(makeAxiosHttpClient).toHaveBeenCalled();
  });

  it("should pass the correct arguments to HttpGetStudentGradesService constructor", () => {
    const service = makeHttpGetStudentGradesService(studentId);

    expect(service).toBeInstanceOf(HttpGetStudentGradesService);
    expect((service as any).url).toBe(mockApiUrl);
    expect((service as any).httpGetClient).toBe(mockHttpClient);
  });
});
