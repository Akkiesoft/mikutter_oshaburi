# -*- coding: utf-8 -*-

Plugin.create :mikutter_oshaburi do
	command(:mikutter_oshaburi,
		name: 'ローカルにツイートする',
		condition: lambda{ |opt| true },
		visible: true,
		role: :postbox
	) do |opt|
		begin
			savedir = UserConfig[:mikutter_oshaburi_path]

			# メッセージを取得
			message = Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text

			if message != "" then
				FileUtils.mkdir_p(File.expand_path(savedir))
				File.open(File.expand_path("#{savedir}/#{Time.now.strftime('%Y-%m-%d')}.txt"), 'a'){ |wp|
					wp.write("#{Time.now.to_s}: #{message}\n")
				}
				Plugin[:gtk].widgetof(opt.widget).widget_post.buffer.text = ""
			end

		end
	end

	settings "ローカルツイート" do
		input('保存先ディレクトリ', :mikutter_oshaburi_path)
	end
end
