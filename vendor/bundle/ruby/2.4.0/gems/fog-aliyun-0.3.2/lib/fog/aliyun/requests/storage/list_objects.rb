# frozen_string_literal: true

module Fog
  module Storage
    class Aliyun
      class Real
        def list_objects(options = {})
          bucket = options[:bucket]
          bucket ||= @aliyun_oss_bucket
          prefix = options[:prefix]
          marker = options[:marker]
          maxKeys = options[:maxKeys]
          delimiter = options[:delimiter]

          path = ''
          if prefix
            path += '?prefix=' + prefix
            path += '&marker=' + marker if marker
            path += '&max-keys=' + maxKeys if maxKeys
            path += '&delimiter=' + delimiter if delimiter

          elsif marker
            path += '?marker=' + marker
            path += '&max-keys=' + maxKeys if maxKeys
            path += '&delimiter=' + delimiter if delimiter

          elsif maxKeys
            path += '?max-keys=' + maxKeys
            path += '&delimiter=' + delimiter if delimiter
          elsif delimiter
            path += '?delimiter=' + delimiter
          end

          resource = bucket + '/'
          ret = request(
            expects: [200, 203, 400],
            method: 'GET',
            path: path,
            resource: resource,
            bucket: bucket
          )
          xml = ret.data[:body]
          XmlSimple.xml_in(xml)
        end

        def list_multipart_uploads(bucket, endpoint, _options = {})
          if endpoint.nil?
            location = get_bucket_location(bucket)
            endpoint = 'http://' + location + '.aliyuncs.com'
          end
          path = '?uploads'
          resource = bucket + '/' + path

          ret = request(
            expects: 200,
            method: 'GET',
            path: path,
            bucket: bucket,
            resource: resource,
            endpoint: endpoint
          )
          XmlSimple.xml_in(ret.data[:body])['Upload']
        end

        def list_parts(bucket, object, endpoint, uploadid, _options = {})
          if endpoint.nil?
            location = get_bucket_location(bucket)
            endpoint = 'http://' + location + '.aliyuncs.com'
          end
          path = object + '?uploadId=' + uploadid
          resource = bucket + '/' + path

          ret = request(
            expects: 200,
            method: 'GET',
            path: path,
            bucket: bucket,
            resource: resource,
            endpoint: endpoint
          )
          XmlSimple.xml_in(ret.data[:body])['Part']
        end
      end
    end
  end
end
