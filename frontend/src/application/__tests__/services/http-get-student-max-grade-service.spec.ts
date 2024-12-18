import { UnexpectedError } from "../../../domain/exceptions";
import { HttpClient, HttpStatusCode } from "../../../shared_kernel";
import { HttpGetStudentMaxGradeService } from "../../services/http-get-student-max-grade-service";

jest.mock("axios", () => ({
  get: jest.fn().mockResolvedValue({
    data: { 
      id: "c9667d02-451b-45cd-9b29-94eb4b6a2be1", 
      name: "John Doe",
      final_grade: 50.0, 
    },
  }),
}));

const httpClient: jest.Mocked<HttpClient<any>> = {
  request: jest.fn(),
};

describe("HttpGetStudentMaxGradeService", () => {
  const url = "http://example.com/student-max-grade";
  let service: HttpGetStudentMaxGradeService;

  beforeEach(() => {
    service = new HttpGetStudentMaxGradeService(url, httpClient);
  });

  it("should return the data when the response status is 200 OK", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.ok,
      body: { 
        id: "c9667d02-451b-45cd-9b29-94eb4b6a2be1", 
        name: "John Doe",
        final_grade: 50.0, 
      },
    };
    httpClient.request.mockResolvedValue(mockResponse);

    const result = await service.execute();

    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({ 
      id: "c9667d02-451b-45cd-9b29-94eb4b6a2be1", 
      name: "John Doe",
      final_grade: 50.0, 
    });
  });

  it("should return the data when the response status is 404 Not Found", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.notFound,
      body: { message: "Student max grade not found" },
    };
    httpClient.request.mockResolvedValue(mockResponse);
    const result = await service.execute();

    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({ message: "Student max grade not found" });
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
