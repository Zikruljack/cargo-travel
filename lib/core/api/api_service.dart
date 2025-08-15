import 'package:dio/dio.dart';
import 'api_client.dart';
import 'base_api_service.dart';
import '../responses/api_response.dart';

class ApiService implements BaseApiService {
  final ApiClient _apiClient = ApiClient.instance;

  @override
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }

  @override
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }

  @override
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _apiClient.dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }

  @override
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _apiClient.dio.delete(
        endpoint,
        queryParameters: queryParameters,
      );
      return _handleResponse(response, fromJson);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }

  ApiResponse<T> _handleResponse<T>(
    Response response,
    T Function(dynamic)? fromJson,
  ) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      if (fromJson != null) {
        return ApiResponse.success(fromJson(response.data));
      } else {
        return ApiResponse.success(response.data as T);
      }
    } else {
      return ApiResponse.error(
        'Request failed with status: ${response.statusCode}',
      );
    }
  }

  ApiResponse<T> _handleError<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiResponse.error('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiResponse.error('Send timeout');
      case DioExceptionType.receiveTimeout:
        return ApiResponse.error('Receive timeout');
      case DioExceptionType.badResponse:
        return ApiResponse.error(
          'Server error: ${error.response?.statusCode ?? 'Unknown'}',
        );
      case DioExceptionType.cancel:
        return ApiResponse.error('Request cancelled');
      default:
        return ApiResponse.error('Network error occurred');
    }
  }
}
