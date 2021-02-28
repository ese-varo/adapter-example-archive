# Target class (used by client)
class TextMessage
  def initialize(content, author)
    @content = content
    @author  = author
  end

  def display
    puts "#{@author} says:"
    puts @content
    puts Time.now.ctime
  end
end

# Adaptee class (useful behavior / wrong interface)
class AudioMessage
  attr_reader :audio, :author

  def initialize(audio, author)
    @audio  = audio
    @author = author
  end
end

# Adapter class (create interface compatibility)
class TextMessageAdapter
  def initialize(audio_message)
    @audio_message = audio_message
  end

  def display
    puts "#{@audio_message.author} says:"
    puts content
    puts Time.now.ctime
  end

  def content
    # translates audio to text
    @audio_message.audio.join(' ')
  end
end

# client implementation
def client_stuff(message)
  message.display
end

text_message = TextMessage.new('This is the message body', 'El fulanito')

audio_message = AudioMessage.new(%w!hola this is an audio message translated!, 'El Arnoldo')
audio_message_translated = TextMessageAdapter.new(audio_message)

puts 'A normal text message'
client_stuff(text_message)

puts
puts 'An audio message converted to text'
client_stuff(audio_message_translated)

# Modifying a class
# open the class and add required methods (require it if needed)
class AudioMessage
  def display
    puts "#{author} says:"
    puts audio.join(' ')
    puts Time.now.ctime
  end
end

# Modifying a single instance
class << audio_message
  def display
    puts "#{author} says:"
    puts audio.join(' ')
    puts Time.now.ctime
  end
end
