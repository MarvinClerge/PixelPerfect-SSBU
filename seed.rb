require 'open-uri' # used to browse to and open webpages
require 'nokogiri' # used to parse and search through HTML
require 'json' # used to create JSON file


# Create hash with characters and populate JSON file
def run
  hash = {}

  get_characters(hash)
  get_images(hash)

  # Create a JSON file in "write only" mode and fill character information
  File.open("data.json","w") do |file|
    file.write(hash.to_json)
  end
end


# Create hash with characters' name in order of appearence
def get_characters(hash)
  # Open webpage and obtain HTML
  url = "https://www.eurogamer.net/articles/2018-11-01-super-smash-bros-ultimate-characters-switch-5778"
  document = Nokogiri::HTML(open(url))

  # Find characters in webpage via CSS
  characters = document.css('div.table-wrapper tbody tr')

  # Iterate through each character with counter for order
  counter = 0
  characters.each do |row|
    # Remove number from character name string
    name = row.css('td')[0].text.split(': ')[1]
    counter += 1

    hash["#{name}"] = {number: counter}
  end
end


# Find character's table and call get_portraits_and_icons() with HTML
def get_images(hash)
  url = open("https://www.mariowiki.com/Super_Smash_Bros._Ultimate")
  document = Nokogiri::HTML(url)

  veteran_table = document.css(".gallery.mw-gallery-traditional")[0]
  newcomers_table = document.css(".gallery.mw-gallery-traditional")[1]

  get_portraits_and_icons(hash, veteran_table)
  get_portraits_and_icons(hash, newcomers_table)
end


# Create hash with characters' portrait, image and icon in given element
def get_portraits_and_icons(hash, element)
  # Iterate through each character and obtain portrait and icon
  element.css("li.gallerybox").each do |cell|

    # Retreive name in li for hash comparision
    name = cell.text.split("(")[0].strip() # Remove (notes)
    name = name.split(" ")[1..-1].join(" ") # Remove order number

    if !!hash[name] # If the character exsists in the hash
      # Find portrait link in HTML and add to hash
      portrait_url = cell.css('a').attr('href').value
      hash[name][:portrait] = "https://www.mariowiki.com" + portrait_url

      # Find image link in HTML and add to hash
      image_url = cell.css('a').attr('href').value
      hash[name][:image] = get_image(image_url)

      # Find icon link in HTML and add to hash
      icon_url = cell.css("div.gallerytext img").attr('src').value
      hash[name][:icon] = "https://www.mariowiki.com" + icon_url
    end
  end
end


# Obtain high quaility image using given url
def get_image(image_url)
  # Open webpage and obtain HTML
  url = "https://www.mariowiki.com" + image_url
  document = Nokogiri::HTML(open(url))

  image_element = document.css('div.fullImageLink a')
  image_path = image_element.attr('href').value
  image = "https://www.mariowiki.com" + image_path

  return image
end


run()
