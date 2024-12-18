import { UnexpectedError } from "../../../domain/exceptions";
import { HttpClient, HttpStatusCode } from "../../../shared_kernel";
import { HttpGetHistoriesService } from "../../services/http-get-histories-service";

jest.mock("axios", () => ({
  get: jest.fn().mockResolvedValue({
    data: { histories: [{ id: 1, name: "History 1" }] },
  }),
}));

const httpClient: jest.Mocked<HttpClient<any>> = {
  request: jest.fn(),
};

describe("HttpGetHistoriesService", () => {
  const url = "http://example.com/histories";
  let service: HttpGetHistoriesService;

  beforeEach(() => {
    service = new HttpGetHistoriesService(url, httpClient);
  });

  it("should return the data when the response status is 200 OK", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.ok,
      body: { histories: [{ id: 1, name: "History 1" }] },
    };
    httpClient.request.mockResolvedValue(mockResponse);

    const result = await service.execute();

    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({
      histories: [{ id: 1, name: "History 1" }],
    });
  });

  it("should return the data when the response status is 404 Not Found", async () => {
    const mockResponse = {
      statusCode: HttpStatusCode.notFound,
      body: { message: "Histories not found" },
    };
    httpClient.request.mockResolvedValue(mockResponse);

    const result = await service.execute();

    expect(httpClient.request).toHaveBeenCalledWith({
      url: url,
      method: "get",
    });
    expect(result.value).toEqual({ message: "Histories not found" });
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
