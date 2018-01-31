module PdfToPng
  module Processor
    class Base
      include FileModel::Processor::Base

      def process(model:, context: {})
        file = Tempfile.new(%W[output .png])

        cmd = [
          'convert',
          '-alpha opaque',
          '-flatten',
          '-geometry 2109x1818',
          '-colors 64',
          '-depth 8',
          '-density 450',
          '+dither'
        ] + [ model.escaped.to_s, file.path ]

        run_command(cmd.join(' '))

        copy(
          file,
          compose_path(model)
        )
      end

      private

      # Returns an Pathname
      def compose_path(model)
        export_path + model.dir_path + Pathname(model.name.to_s + '.png')
      end

    end
  end
end
