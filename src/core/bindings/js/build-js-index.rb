def download url #simple!
  require 'net/http'
  require 'uri'
  html=Net::HTTP.get URI.parse(url)
end

libs={}
html= download "http://cdnjs.com/"
html.scan /cdnjs.cloudflare.com(.*?)"?>?</ do |x,_|
  x=x.gsub "&#x2F;","/"
  match=x.match(/.*\/(.*?)\.js$/)
  if (match)
    libs[match[1]]="http://cdnjs.cloudflare.com"+x
    short=match[1].gsub(/\..*/,"").gsub(/\-.*/,"")
    libs[short]="http://cdnjs.cloudflare.com"+x
  end
end
f=File.open("javascript-library-auto-index.rb","w");
f.puts("# DON'T EDIT: auto generated from build-js-index.rb");
f.puts("$js_auto_libs={")
# f.puts(libs)
libs.each{|k,v|f.puts "'#{k}'=>'#{v}',"}
f.puts("}")

