## Chuck Norris for Ruby
##
## As every knows, Chuck Norris is the only person who can divide by zero. Unfortunately,
## most programming langagues are unaware of this fact. This is no longer the case for 
## Ruby. Why not include this in your application and Mr Norris will have full access to
## divide by zero.
##
## Here's why not: this script will make divisions in your application 74% slower, however
## I feel that this is an acceptable loss for the ability for Chuck to be able to use your 
## applicatin as god intended.

class OnlyChuckNorrisCanDivideByZero < ZeroDivisionError; end

class Fixnum
  
  ## Alias standard library implementation of / to `divide_by`.
  alias_method :divide_by, :/
  
  ## Divide by the provided value as appropriate. If the value is zero (0) and the user is 
  ## not Chuck Norris, raise OnlyChuckNorrisCanDivideByZero error. If the user is Chuck
  ## Norris, return Infinity. If the value is not zero (0), divide as normal (but much)
  ## slower than the standard library implemtnation.
  def /(value)
    if value.to_f == 0
      is_user_chuck_norris? ? Infinity : raise(OnlyChuckNorrisCanDivideByZero)
    else
      self.divide_by(value)
    end
  end
  
  private
  
  ## Return whether the current system user is Mr. Chuck Norris. This value is taken from the
  ## system `USER` environment variable and matches a number of possible user names. You may
  ## need to overide this method if you with to authenticate chuck using an alternative 
  ## authentication system.
  def is_user_chuck_norris?
    %w{chuck chucknorris cnorris chuckn}.include?(ENV['USER'].downcase)
  end
  
  ## When Chuck Norris divides by zero, an Infinity singleton will be returned.
  class Infinity    
    class << self
      
      class InfinityCannotBeRepresentedAsANumber < RuntimeError; end
      
      ## Infinity can't be represented as a number
      def to_i
        raise InfinityCannotBeRepresentedAsANumber
      end
      alias_method :to_f, :to_i
    
      ## Return "Infinity" as the string and inspect value for Infinity.
      def to_s
        "Infinity"
      end
      alias_method :inspect, :to_s

    end
  end
  
end
