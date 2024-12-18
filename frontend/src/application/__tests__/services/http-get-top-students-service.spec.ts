import { UnexpectedError } from "../../../domain/exceptions";
import { HttpClient, HttpStatusCode } from "../../../shared_kernel";
import { HttpGetTopStudentsService } from "../../services/http-get-top-students-service";

jest.mock("axios", () => ({
  get: jest.fn().mockResolvedValue({
    data: { students: [{ id: 1, name: "John Doe" }] },
  }),
}));

const httpClient: jest.Mocked<HttpClient<any>> = {
  request: jest.fn(),
};

describe("HttpGetTopStudentsService", () => {
  const url = "http://example.com/top-students";
  let service: HttpGetTopStudentsService;

  beforeEach(() => {
    service = new HttpGetTopStudentsService(url, httpClient);
  });

  it("should return the data when the response status is 200 OK", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.ok,
      body: { students: [{ id: 1, name: "John Doe" }] },
    };
    httpClient.request.mockResolvedValue(mockResponse);
    const result = await service.execute();
    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({ students: [{ id: 1, name: "John Doe" }] });
  });

  it("should return the data when the response status is 404 Not Found", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.notFound,
      body: { message: "No students found" },
    };
    httpClient.request.mockResolvedValue(mockResponse);
    const result = await service.execute();

    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({ message: "No students found" });
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
