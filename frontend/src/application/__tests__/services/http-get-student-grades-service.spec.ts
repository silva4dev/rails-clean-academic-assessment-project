import { UnexpectedError } from "../../../domain/exceptions";
import { HttpClient, HttpStatusCode } from "../../../shared_kernel";
import { HttpGetStudentGradesService } from "../../services/http-get-student-grades-service";

jest.mock("axios", () => ({
  get: jest.fn().mockResolvedValue({
    data: { grades: [{ discipline: { name: "Math" }, value: 90 }], final_grade: 85 },
  }),
}));

const httpClient: jest.Mocked<HttpClient<any>> = {
  request: jest.fn(),
};

describe("HttpGetStudentGradesService", () => {
  const url = "http://example.com/student-grades";
  let service: HttpGetStudentGradesService;

  beforeEach(() => {
    service = new HttpGetStudentGradesService(url, httpClient);
  });

  it("should return the data when the response status is 200 OK", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.ok,
      body: { grades: [{ discipline: { name: "Math" }, value: 90 }], final_grade: 85 },
    };
    httpClient.request.mockResolvedValue(mockResponse);

    const result = await service.execute();

    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({
      grades: [{ discipline: { name: "Math" }, value: 90 }],
      final_grade: 85,
    });
  });

  it("should return the data when the response status is 404 Not Found", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.notFound,
      body: { message: "Student grades not found" },
    };
    httpClient.request.mockResolvedValue(mockResponse);

    const result = await service.execute();

    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({ message: "Student grades not found" });
  });

  it("should throw an UnexpectedError when the response status is not handled", async () => {
    const mockResponse = {
      statusCode: 500,
      body: { message: "Internal server error" },
    };
    httpClient.request.mockResolvedValue(mockResponse);

    await expect(service.execute()).rejects.toThrow(UnexpectedError);
  });
});
