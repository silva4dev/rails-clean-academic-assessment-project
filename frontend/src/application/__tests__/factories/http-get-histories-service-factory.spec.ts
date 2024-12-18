import { makeApiUrl, makeAxiosHttpClient } from "../../../shared_kernel";
import { makeHttpGetHistoriesService } from "../../factories/http-get-histories-service-factory";
import { HttpGetHistoriesService } from "../../services/http-get-histories-service";

jest.mock("axios");

jest.mock("../../../shared_kernel", () => ({
  makeApiUrl: jest.fn(),
  makeAxiosHttpClient: jest.fn(),
}));

describe("makeHttpGetHistoriesService", () => {
  const mockApiUrl = "http://example.com/api/v1/histories/students/123";
  const mockHttpClient = { request: jest.fn() };
  const studentId = "123";

  beforeEach(() => {
    (makeApiUrl as jest.Mock).mockReturnValue(mockApiUrl);
    (makeAxiosHttpClient as jest.Mock).mockReturnValue(mockHttpClient);
  });

  it("should return an instance of HttpGetHistoriesService", () => {
    const service = makeHttpGetHistoriesService(studentId);
    expect(service).toBeInstanceOf(HttpGetHistoriesService);
  });

  it("should call makeApiUrl with the correct argument", () => {
    makeHttpGetHistoriesService(studentId);
    expect(makeApiUrl).toHaveBeenCalledWith(`/api/v1/histories/students/${studentId}`);
  });

  it("should call makeAxiosHttpClient", () => {
    makeHttpGetHistoriesService(studentId);
    expect(makeAxiosHttpClient).toHaveBeenCalled();
  });

  it("should pass the correct arguments to HttpGetHistoriesService constructor", () => {
    const service = makeHttpGetHistoriesService(studentId);

    expect(service).toBeInstanceOf(HttpGetHistoriesService);
    expect((service as any).url).toBe(mockApiUrl);
    expect((service as any).httpGetClient).toBe(mockHttpClient);
  });
});
