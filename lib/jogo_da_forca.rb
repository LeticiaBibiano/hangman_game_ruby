require_relative 'loading.rb'
require_relative 'game_over.rb'
require_relative 'win.rb'

class JogoDaForca

  attr_reader :chute

    def initialize 
        Loader.loading

        @palavra = palavras.sample #requisita palavras aleatoriamente.
        @tentativas = 5
        @chute_certo = []
        @chute = []
        @acertos = []
    
    end

    def start #pede uma letra ao usuário
        puts "COMEÇOU... a palavra tem #{@palavra.first.size} letras." #retorna o tamanho do primeiro valor do array.
        tracinhos #invocamos os tracinhos com o tamanho exato da palavra.
        sleep 2

        puts "Dica: #{@palavra.last}" #retorna o último valor do array = dica.
        sleep 4

        advinhar_letra #invocamos o método advinhar_letra
    end
    
    def palavras #palavra, dica da palavra
        [
            ["ruby", "Linguagem de programação preciosa."],
            ["initialize", "Um método inicializador."],
            ["branca", "A cor do cavalo branco de Napoleão."],
            ["relogio", "Aquilo que dá muitas voltas, mas não sai do lugar."],
            ["alho", "Tem cabeça, tem dente, não é bicho, não é gente."],
            ["ponte", "Atravessa o rio, mas não se molha"],
            ["javali", "Um animal que não vale mais nada."],
            ["pescoco", "Aquilo que faz a cabeça de um homem virar."],
            ["silencio", "Num instante se quebra quando se diz o nome dele."],
            ["pente", "Aquilo que tem dentes, mas não come."],
        ]        
    end

    def tracinhos 
        tamanho_palavra = ""

        @palavra.first.size.times do #retorna em tracinhos o tamanho do valor.
            tamanho_palavra += "_ "
        end        

        puts tamanho_palavra
    end

    def advinhar_letra
        if @tentativas > 0
            puts "Advinhe uma letra..."
            @chute = gets.chomp
            
            #verificando se a letra inserida está na palavra.
            @chute_certo = @palavra.first.include? @chute 

            if @chute.size != 1
              puts "Hey!!! Chute apenas uma letra por vez!"

              advinhar_letra

            elsif @chute_certo
              puts "Você acertou uma letra!"
                
                @acertos << @palavra.first.chars.select{|letra| letra == @chute}
                @acertos.flatten!
                
              mostrar_letra
                
              if @palavra.first.size != @acertos.join.size
                    advinhar_letra
                else
                    Win.you_win
              end

            else
                @tentativas -= 1
                puts "Ops... restam #{ @tentativas } chances... tente novamente!"
                advinhar_letra
            end 
        else
            GameOver.game_over            
        end
    end

    def mostrar_letra
        pl = ""
        @palavra.first.chars.each do |letra|
            pl << (@acertos.include?(letra) ? letra : '_ ') + ' '
        end  
        
        puts pl
    end
end