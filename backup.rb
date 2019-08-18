require 'net/ftp'
require 'zip'

module Minecraft
  class BackupError < StandardError; end

  class Backup
    class << self
      def create(dir)
        create_backup(dir)
      end

      private

      def create_backup(dir)
        zip = Zip::OutputStream.write_buffer do |zos|
          fetch_files(dir).each do |ftp_file_path|
            zos.put_next_entry ftp_file_path.gsub(%r{^\/}, '')

            zos.print(ftp_file_data(ftp_file_path))
          end
        end

        zip.rewind

        File.open("#{backup_destination}#{backup_filename}", 'w') { |f| f.write zip.read }
      end

      def backup_filename
        time_format = '%Y-%m-%dT%H-%M-%S' # "2019-08-18T12-17-57"

        "#{ENV['WORLD_DIR']}_#{Time.now.strftime(time_format)}.zip"
      end

      def backup_destination
        '../backups/'
      end

      def fetch_files(dir, accumulator = [])
        ftp.chdir dir

        ftp.list do |entry|
          if directory? entry
            fetch_files(entry.split.last, accumulator)
          else
            accumulator.push filepath(entry)
          end
        end

        ftp.chdir '..'
        accumulator
      end

      def ftp_file_data(filepath)
        data = ''
        ftp.retrbinary('RETR ' + filepath, Net::FTP::DEFAULT_BLOCKSIZE) do |block|
          data << block
        end

        data
      end

      def ftp
        @ftp ||= Net::FTP.new(ENV['FTP_HOST'], ENV['FTP_USERNAME'], ENV['FTP_PASSWORD'])
      end

      def directory?(entry)
        entry.split(/\s+/)[0][0, 1] == 'd'
      end

      def filepath(entry)
        ftp.pwd + '/' + entry.split.last
      end
    end
  end
end
