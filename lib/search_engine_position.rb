# = SearchEnginePosition
# SearchEnginePosition is a simple Ruby class made for help SEO administrator controling your websites position in many diferents search engines
#
# Author::    Fernando Gomes  (mailto:feromes@gmail.com)
# Copyright:: Copyright (c) 2008 Fernando Gomes
# License::   Distributes under the same terms as Ruby

class SearchEnginePosition

  require 'hpricot'
  require 'open-uri'
  
  SEARCH_ENGINES = {"www.google.com" => {:default_lang => "en", :main => :google, :country => "International"},
                    "www.google.ad"  => {:default_lang => nil, :main => :google, :country => "Andorra"},
                    "www.google.ae"  => {:default_lang => nil, :main => :google, :country => "الامارات العربية المتحدة	"},
                    "www.google.com.af"  => {:default_lang => nil, :main => :google, :country => "افغانستان"},
                    "www.google.com.ag"  => {:default_lang => nil, :main => :google, :country => "Antigua and Barbuda"},
                    "www.google.com.ai"  => {:default_lang => nil, :main => :google, :country => "Anguilla"},
                    "www.google.am"  => {:default_lang => nil, :main => :google, :country => "Հայաստան"},
                    "www.google.it.ao"  => {:default_lang => "pt-PT", :main => :google, :country => "Angola"},
                    "www.google.com.ar"  => {:default_lang => nil, :main => :google, :country => "Argentina"},
                    "www.google.as"  => {:default_lang => "en", :main => :google, :country => "American Samoa"},
                    "www.google.at"  => {:default_lang => nil, :main => :google, :country => "Österreich"},
                    "www.google.com.au" => {:default_lang => "en", :main => :google, :country => "Australia"},
                    "www.google.az" => {:default_lang => nil, :main => :google, :country => "Azərbaycan"},
                    "www.google.ba" => {:default_lang => nil, :main => :google, :country => "Bosna i Hercegovina"},
                    "www.google.com.bd" => {:default_lang => nil, :main => :google, :country => "বাংলাদেশ"},
                    "www.google.be" => {:default_lang => nil, :main => :google, :country => "België"},
                    "www.google.bg" => {:default_lang => nil, :main => :google, :country => "България"},
                    "www.google.com.bh" => {:default_lang => nil, :main => :google, :country => "البحرين"},
                    "www.google.bi" => {:default_lang => nil, :main => :google, :country => "Burundi"},
                    "www.google.com.bn" => {:default_lang => nil, :main => :google, :country => "Brunei"},
                    "www.google.com.bo" => {:default_lang => "es", :main => :google, :country => "Bolivia"},
                    "www.google.com.br" => {:default_lang => "pt-BR", :main => :google, :country => "Brasil"},
                    "www.google.bs" => {:default_lang => nil, :main => :google, :country => "The Bahamas"},
                    "www.google.co.bw" => {:default_lang => nil, :main => :google, :country => "Botswana"},
                    "www.google.com.by" => {:default_lang => nil, :main => :google, :country => "Беларусь"},
                    "www.google.com.bz" => {:default_lang => nil, :main => :google, :country => "Belize"},
                    "www.google.ca" => {:default_lang => "en", :main => :google, :country => "Canada"},
                    "www.google.cd" => {:default_lang => nil, :main => :google, :country => "Rep. Dem. du Congo"},
                    "www.google.cg" => {:default_lang => nil, :main => :google, :country => "Rep. du Congo"},
                    "www.google.ch" => {:default_lang => nil, :main => :google, :country => "Schweiz"},
                    "www.google.ci" => {:default_lang => nil, :main => :google, :country => "Cote D'Ivoire"},
                    "www.google.co.ck" => {:default_lang => nil, :main => :google, :country => "Cook Islands"},
                    "www.google.cl"	 => {:default_lang => "es", :main => :google, :country => "Chile"},
                    "www.google.cn"	 => {:default_lang => nil, :main => :google, :country => "中国"},
                    "www.google.com.co"	 => {:default_lang => "es", :main => :google, :country => "Colombia"},
                    "www.google.co.cr"	 => {:default_lang => "es", :main => :google, :country => "Costa Rica"},
                    "www.google.com.cu"	 => {:default_lang => "es", :main => :google, :country => "Cuba"},
                    "www.google.cz"	 => {:default_lang => nil, :main => :google, :country => "Česká republika"},
                    "www.google.de"	 => {:default_lang => nil, :main => :google, :country => "Deutschland"},
                    "www.google.dj"	 => {:default_lang => nil, :main => :google, :country => "Djibouti"},
                    "www.google.dk"	 => {:default_lang => nil, :main => :google, :country => "Danmark	"},
                    "www.google.dm" => {:default_lang => nil, :main => :google, :country => "Dominica	"},
                    "www.google.com.do" => {:default_lang => nil, :main => :google, :country => "Rep. Dominicana"},
                    "www.google.dz" => {:default_lang => nil, :main => :google, :country => "Algérie"},
                    "www.google.com.ec" => {:default_lang => "es", :main => :google, :country => "Ecuador"},
                    "www.google.ee" => {:default_lang => nil, :main => :google, :country => "Eesti"},
                    "www.google.com.eg" => {:default_lang => nil, :main => :google, :country => "مصر"},
                    "www.google.es" => {:default_lang => "es", :main => :google, :country => "España"},
                    "www.google.com.et" => {:default_lang => nil, :main => :google, :country => "ኢትዮጵያ"},
                    "www.google.fi" => {:default_lang => nil, :main => :google, :country => "Suomi"},
                    "www.google.com.fj" => {:default_lang => nil, :main => :google, :country => "Fiji"},
                    "www.google.fm" => {:default_lang => nil, :main => :google, :country => "Micronesia"},
                    "www.google.fr" => {:default_lang => "fr", :main => :google, :country => "France"},
                    "www.google.ge" => {:default_lang => nil, :main => :google, :country => "საქართველო"},
                    "www.google.gg" => {:default_lang => nil, :main => :google, :country => "Guernsey"},
                    "www.google.com.gh" => {:default_lang => nil, :main => :google, :country => "Ghana"},
                    "www.google.com.gi" => {:default_lang => nil, :main => :google, :country => "Gibraltar"},
                    "www.google.gl" => {:default_lang => nil, :main => :google, :country => "Grønlands"},
                    "www.google.gm" => {:default_lang => nil, :main => :google, :country => "The Gambia"},
                    "www.google.gp" => {:default_lang => nil, :main => :google, :country => "Guadeloupe"},
                    "www.google.gr" => {:default_lang => nil, :main => :google, :country => "Ελλάς"},
                    "www.google.com.gt" => {:default_lang => nil, :main => :google, :country => "Guatemala"},	
                    "www.google.gy" => {:default_lang => nil, :main => :google, :country => "Guyana"},
                    "www.google.com.hk" => {:default_lang => nil, :main => :google, :country => "香港"},
                    "www.google.hn" => {:default_lang => nil, :main => :google, :country => "Honduras"},
                    "www.google.hr" => {:default_lang => nil, :main => :google, :country => "Hrvatska"},
                    "www.google.ht" => {:default_lang => nil, :main => :google, :country => "Haïti"},
                    "www.google.hu" => {:default_lang => nil, :main => :google, :country => "Magyarország"},
                    "www.google.co.id" => {:default_lang => nil, :main => :google, :country => "Indonesia"},
                    "www.google.ie" => {:default_lang => "en", :main => :google, :country => "Ireland"},
                    "www.google.co.il" => {:default_lang => nil, :main => :google, :country => "ישראל"},
                    "www.google.im" => {:default_lang => nil, :main => :google, :country => "Isle of Man"},
                    "www.google.co.in" => {:default_lang => nil, :main => :google, :country => "India"},
                    "www.google.is" => {:default_lang => nil, :main => :google, :country => "Ísland"},
                    "www.google.it" => {:default_lang => nil, :main => :google, :country => "Italia"},
                    "www.google.je" => {:default_lang => nil, :main => :google, :country => "Jersey	"},
                    "www.google.com.jm" => {:default_lang => nil, :main => :google, :country => "Jamaica"},
                    "www.google.jo" => {:default_lang => nil, :main => :google, :country => "الأردن	"},
                    "www.google.co.jp" => {:default_lang => nil, :main => :google, :country => "日本"},
                    "www.google.co.ke" => {:default_lang => nil, :main => :google, :country => "Kenya"},
                    "www.google.com.kh" => {:default_lang => nil, :main => :google, :country => "ព្រះរាជាណាចក្រកម្ពុជា"},
                    "www.google.ki" => {:default_lang => nil, :main => :google, :country => "Kiribati"},
                    "www.google.kg" => {:default_lang => nil, :main => :google, :country => "Кыргызстан"},
                    "www.google.co.kr" => {:default_lang => nil, :main => :google, :country => "한국 "},
                    "www.google.kz" => {:default_lang => nil, :main => :google, :country => "Қазақстан"},
                    "www.google.la" => {:default_lang => nil, :main => :google, :country => "ລາວ"},
                    "www.google.li" => {:default_lang => nil, :main => :google, :country => "Liechtenstein"},
                    "www.google.lk" => {:default_lang => nil, :main => :google, :country => "Sri Lanka"},
                    "www.google.co.ls" => {:default_lang => nil, :main => :google, :country => "Lesotho"},
                    "www.google.lt" => {:default_lang => nil, :main => :google, :country => "Lietuvos"},
                    "www.google.lu" => {:default_lang => nil, :main => :google, :country => "Luxemburg"},
                    "www.google.lv" => {:default_lang => nil, :main => :google, :country => "Latvija"},
                    "www.google.com.ly" => {:default_lang => nil, :main => :google, :country => "ليبيــا"},
                    "www.google.co.ma" => {:default_lang => nil, :main => :google, :country => "Maroc"},
                    "www.google.md" => {:default_lang => nil, :main => :google, :country => "Moldova"},
                    "www.google.mn" => {:default_lang => nil, :main => :google, :country => "Монгол улс 	"},
                    "www.google.ms" => {:default_lang => nil, :main => :google, :country => "Montserrat"},
                    "www.google.com.mt" => {:default_lang => nil, :main => :google, :country => "Malta"},
                    "www.google.mu" => {:default_lang => nil, :main => :google, :country => "Mauritius"},
                    "www.google.mv" => {:default_lang => nil, :main => :google, :country => "Maldives"},
                    "www.google.mw" => {:default_lang => nil, :main => :google, :country => "Malawi"},
                    "www.google.com.mx" => {:default_lang => nil, :main => :google, :country => "México"},
                    "www.google.com.my" => {:default_lang => nil, :main => :google, :country => "Malaysia"},
                    "www.google.co.mz" => {:default_lang => nil, :main => :google, :country => "Moçambique"},
                    "www.google.com.na" => {:default_lang => nil, :main => :google, :country => "Namibia"},
                    "www.google.com.nf" => {:default_lang => nil, :main => :google, :country => "Norfolk Island"},
                    "www.google.com.ng" => {:default_lang => nil, :main => :google, :country => "Nigeria"},
                    "www.google.com.ni" => {:default_lang => nil, :main => :google, :country => "Nicaragua"},
                    "www.google.nl" => {:default_lang => nil, :main => :google, :country => "Nederland"},
                    "www.google.no" => {:default_lang => nil, :main => :google, :country => "Norge"},
                    "www.google.com.np" => {:default_lang => nil, :main => :google, :country => "﻿नेपाल"},
                    "www.google.nr" => {:default_lang => nil, :main => :google, :country => "Nauru"},
                    "www.google.nu" => {:default_lang => nil, :main => :google, :country => "Niue"},
                    "www.google.co.nz" => {:default_lang => nil, :main => :google, :country => "New Zealand"},
                    "www.google.com.om" => {:default_lang => nil, :main => :google, :country => "عُمان"},
                    "www.google.com.pa" => {:default_lang => nil, :main => :google, :country => "Panamá"},
                    "www.google.com.pe" => {:default_lang => "es", :main => :google, :country => "Perú"},
                    "www.google.com.ph" => {:default_lang => nil, :main => :google, :country => "Pilipinas"},
                    "www.google.com.pk" => {:default_lang => nil, :main => :google, :country => "Pakistan"},
                    "www.google.pl" => {:default_lang => nil, :main => :google, :country => "Polska"},
                    "www.google.pn" => {:default_lang => nil, :main => :google, :country => "Pitcairn Islands"},
                    "www.google.com.pr" => {:default_lang => nil, :main => :google, :country => "Puerto Rico"},
                    "www.google.pt" => {:default_lang => "pt-PT", :main => :google, :country => "Portugal"},
                    "www.google.com.py" => {:default_lang => "es", :main => :google, :country => "Paraguay"},
                    "www.google.com.qa" => {:default_lang => nil, :main => :google, :country => "قطر"},
                    "www.google.ro" => {:default_lang => nil, :main => :google, :country => "România	"},
                    "www.google.ru" => {:default_lang => nil, :main => :google, :country => "Россия"},
                    "www.google.rw" => {:default_lang => nil, :main => :google, :country => "Rwanda"},
                    "www.google.com.sa" => {:default_lang => nil, :main => :google, :country => "السعودية"},
                    "www.google.com.sb" => {:default_lang => nil, :main => :google, :country => "Solomon Islands"},
                    "www.google.sc" => {:default_lang => nil, :main => :google, :country => "Seychelles"},
                    "www.google.se" => {:default_lang => nil, :main => :google, :country => "Sverige"},
                    "www.google.com.sg" => {:default_lang => nil, :main => :google, :country => "Singapore"},
                    "www.google.sh" => {:default_lang => nil, :main => :google, :country => "Saint Helena"},
                    "www.google.si" => {:default_lang => nil, :main => :google, :country => "Slovenija"},
                    "www.google.sk" => {:default_lang => nil, :main => :google, :country => "Slovensko"},
                    "www.google.sn" => {:default_lang => nil, :main => :google, :country => "Sénégal"},
                    "www.google.sm" => {:default_lang => nil, :main => :google, :country => "San Marino"},
                    "www.google.st" => {:default_lang => nil, :main => :google, :country => "São Tomé e Príncipe"},
                    "www.google.com.sv" => {:default_lang => nil, :main => :google, :country => "El Salvador"},
                    "www.google.co.th" => {:default_lang => nil, :main => :google, :country => "ประเทศไทย	"},
                    "www.google.com.tj" => {:default_lang => nil, :main => :google, :country => "Tajikistan"},
                    "www.google.tk" => {:default_lang => nil, :main => :google, :country => "Tokelau"},
                    "www.google.tl" => {:default_lang => nil, :main => :google, :country => "Timor-Leste"},
                    "www.google.tm" => {:default_lang => nil, :main => :google, :country => "Türkmenistan"},
                    "www.google.to" => {:default_lang => nil, :main => :google, :country => "Tonga"},
                    "www.google.com.tr" => {:default_lang => nil, :main => :google, :country => "Türkiye"},
                    "www.google.tt" => {:default_lang => nil, :main => :google, :country => "Trinidad and Tobago"},
                    "www.google.com.tw" => {:default_lang => nil, :main => :google, :country => "台灣"},
                    "www.google.co.tz" => {:default_lang => nil, :main => :google, :country => "Tanzania"},
                    "www.google.com.ua" => {:default_lang => nil, :main => :google, :country => "Україна"},
                    "www.google.co.ug" => {:default_lang => nil, :main => :google, :country => "Uganda"},
                    "www.google.co.uk" => {:default_lang => "en", :main => :google, :country => "UK"},
                    "www.google.com.uy" => {:default_lang => "es", :main => :google, :country => "Uruguay"},
                    "www.google.co.uz" => {:default_lang => nil, :main => :google, :country => "O'zbekiston"},
                    "www.google.com.vc" => {:default_lang => nil, :main => :google, :country => "Saint Vincent and the Grenadines"},
                    "www.google.co.ve" => {:default_lang => "es", :main => :google, :country => "Venezuela"},
                    "www.google.vg" => {:default_lang => nil, :main => :google, :country => "British Virgin Islands"},
                    "www.google.co.vi" => {:default_lang => nil, :main => :google, :country => "Virgin Islands"},
                    "www.google.com.vn" => {:default_lang => nil, :main => :google, :country => "Việt Nam"},
                    "www.google.vu" => {:default_lang => nil, :main => :google, :country => "Vanuatu"},
                    "www.google.ws" => {:default_lang => nil, :main => :google, :country => "Samoa"},
                    "www.google.rs" => {:default_lang => nil, :main => :google, :country => "Србија"},
                    "www.google.co.za" => {:default_lang => "en", :main => :google, :country => "South Africa"},
                    "www.google.co.zm" => {:default_lang => nil, :main => :google, :country => "Zambia"},
                    "www.google.co.zw" => {:default_lang => nil, :main => :google, :country => "Zimbabwe"},
                    "br.search.yahoo.com" => {:default_lang => "lang_pt", :main => :yahoo, :country => "Brazil"},
                    "search.msn.com.br" => {:default_lang =>"pt-BR", :main => :msn, :country => "Brazil"},
                    "search.msn.com" => {:default_lang => "en", :main => :msn, :country => "United States"}}
  LANGUAGES = {:google => { "af" => "Afrikaans",
                            "sq" => "Albanian",
                            "am" => "Amharic",
                            "ar" => "Arabic",
                            "hy" => "Armenian",
                            "az" => "Azerbaijani",
                            "eu" => "Basque",
                            "be" => "Belarusian",
                            "bn" => "Bengali",
                            "bh" => "Bihari",
                            "xx-bork" => "Bork, bork, bork!",
                            "bs" => "Bosnian",
                            "br" => "Breton",
                            "bg" => "Bulgarian",
                            "km" => "Cambodian",
                            "ca" => "Catalan",
                            "zh-CN" => "Chinese (Simplified)",
                            "zh-TW" => "Chinese (Traditional)",
                            "co" => "Corsican",
                            "hr" => "Croatian",
                            "cs" => "Czech",
                            "da" => "Danish",
                            "nl" => "Dutch",
                            "xx-elmer" => "Elmer Fudd",
                            "en" => "English",
                            "eo" => "Esperanto",
                            "et" => "Estonian",
                            "fo" => "Faroese",
                            "tl" => "Filipino",
                            "fi" => "Finnish",
                            "fr" => "French",
                            "fy" => "Frisian",
                            "gl" => "Galician",
                            "ka" => "Georgian",
                            "de" => "German",
                            "el" => "Greek",
                            "gn" => "Guarani",
                            "gu" => "Gujarati",
                            "xx-hacker" => "Hacker",
                            "iw" => "Hebrew",
                            "hi" => "Hindi",
                            "hu" => "Hungarian",
                            "is" => "Icelandic",
                            "id" => "Indonesian",
                            "ia" => "Interlingua",
                            "ga" => "Irish",
                            "it" => "Italian",
                            "ja" => "Japanese",
                            "jw" => "Javanese",
                            "kn" => "Kannada",
                            "kk" => "Kazakh",
                            "xx-klingon" => "Klingon",
                            "ko" => "Korean",
                            "ku" => "Kurdish",
                            "ky" => "Kyrgyz",
                            "lo" => "Laothian",
                            "la" => "Latin",
                            "lv" => "Latvian",
                            "ln" => "Lingala",
                            "lt" => "Lithuanian",
                            "mk" => "Macedonian",
                            "ms" => "Malay",
                            "ml" => "Malayalam",
                            "mt" => "Maltese",
                            "mi" => "Maori",
                            "mr" => "Marathi",
                            "mo" => "Moldavian",
                            "mn" => "Mongolian",
                            "sr-ME" => "Montenegrin",
                            "ne" => "Nepali",
                            "no" => "Norwegian",
                            "nn" => "Norwegian (Nynorsk)",
                            "oc" => "Occitan",
                            "or" => "Oriya",
                            "ps" => "Pashto",
                            "fa" => "Persian",
                            "xx-pirate" => "Pirate",
                            "pl" => "Polish",
                            "pt-BR" => "Portuguese (Brazil)",
                            "pt-PT" => "Portuguese (Portugal)",
                            "pa" => "Punjabi",
                            "qu" => "Quechua",
                            "ro" => "Romanian",
                            "rm" => "Romansh",
                            "ru" => "Russian",
                            "gd" => "Scots Gaelic",
                            "sr" => "Serbian",
                            "sh" => "Serbo-Croatian",
                            "st" => "Sesotho",
                            "sn" => "Shona",
                            "sd" => "Sindhi",
                            "si" => "Sinhalese",
                            "sk" => "Slovak",
                            "sl" => "Slovenian",
                            "so" => "Somali",
                            "es" => "Spanish",
                            "su" => "Sundanese",
                            "sw" => "Swahili",
                            "sv" => "Swedish",
                            "tg" => "Tajik",
                            "ta" => "Tamil",
                            "tt" => "Tatar",
                            "te" => "Telugu",
                            "th" => "Thai",
                            "ti" => "Tigrinya",
                            "to" => "Tonga",
                            "tr" => "Turkish",
                            "tk" => "Turkmen",
                            "tw" => "Twi",
                            "ug" => "Uighur",
                            "uk" => "Ukrainian",
                            "ur" => "Urdu",
                            "uz" => "Uzbek",
                            "vi" => "Vietnamese",
                            "cy" => "Welsh",
                            "xh" => "Xhosa",
                            "yi" => "Yiddish",
                            "yo" => "Yoruba",
                            "zu" => "Zulu"},
               :yahoo => {"lang_pt" => "Portuguese (Brazilian)"},
               :msn => {"pt-BR" => "Portuguese (Brazilian)", 
                        "en" => "English"}}
  
  # Return a SearchEenginePosition Object of a given site, on the given search engine, for the given keyword, on the given languages
  def initialize(site, keyword, search_engine = nil, language = nil)
    @site = site 
    @keyword = URI.escape(keyword) 
    @search_engine = verify_search_engine(search_engine)
    @language = language || SEARCH_ENGINES[@search_engine][:default_lang]
    @page_result = Hpricot(open(search_url))
  end

  # Return the rank positions 
  def position
    @results = []  
    @page_result.search('li').each do |p|
      result = p.search("a[@href*=#{@site}]")
      unless result.empty?
        @results << p.position + 1
      end
    end
    return @results
  end
  
  # Show the aproprietaded URL in order to search 
  def search_url
    case SEARCH_ENGINES[@search_engine][:main]
    when :google
      "http://#{@search_engine}/search?num=100&hl=#{@language}&query=#{@keyword}"
    when :yahoo
      "http://#{@search_engine}/search?n=100&p=#{@keyword}&vl=#{@language}"
    when :msn
      "http://#{@search_engine}/results.aspx?q=#{@keyword}&num=50&mkt=#{@language}&setlang=#{@language}"
    end
  end
  
  private
  
    def verify_search_engine(search_engine)
      if search_engine and SEARCH_ENGINES[search_engine]
        search_engine
      elsif search_engine.nil?
        "www.google.com"
      else
        raise ArgumentError
      end
    end
end
