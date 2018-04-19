#on défini la class golabal nommée TicTacToe
class TicTacToe

    def initialize
        @game = Game.new("","")
    end
#ici ce sont les initialisation des joeurs et des coups gagnant
    class Game
        attr_accessor :player1, :player2

        def initialize (player1, player2)
            @player1 = Player.new(player1)
            @player2 = Player.new(player2)
            #les coups gagnants
            @winning = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
            #les symboles utilisé pour jouer et affichée pendant le jeux
            @symbol1 = "X"
            @symbol2 = "O"

            self.go
        end

#ici ce sont les appeles de tous les méthodes définie dans le jeux pour que le jeux fonctionne bien
        def go
            introduction
            player_names
            Player
            player_assignment
            display_board(@winning)
            play_game
        end
#etite introduction de rien du tout :)
        def introduction
            puts "              ************************************************************************
                                    Tic-Tac-Toe en Ruby Language
                                    Slack: [@tinosam] and [@cédric]
                                          Copyright: (c) 2018 
              ************************************************************************"
            puts "Le règle est simple, chaque joeur vas juste introduire les chiffres correspondant à la case correspondant jusqu'à ce qu'il gagne :) amusez-vous!!!"
            puts "...appuyez sur la touche Entrée pour commencer !"
            puts ""
            @@input = gets.chomp
        end
#ici on recupere les noms des joueurs 1 et 2
        def player_names
            puts "1 . Entrez le pseudo du premier joeurs, vous utilisez le X : "
            name1 = gets.chomp.upcase
            puts ""
            puts "2 . Entrez le pseudo du second joeurs, vous utilisez le O : "
            name2 = gets.chomp.upcase

            @player1.name = name1
            @player2.name = name2
        end
#on assigne les joeurs par rapport à leur nom
        def player_assignment
            @x = rand(10)   

            if @x <= 5
                @player1.symbol = @symbol1
                @player2.symbol = @symbol2
                puts ""
                puts "#{player1.name} va utiliser #{@symbol1} et #{player2.name} va utiliser #{@symbol2}"
                puts ""
            else
                @player1.symbol = @symbol2
                @player2.symbol = @symbol1
                puts ""
                puts "#{player1.name} va utiliser #{@symbol2} et #{player2.name} va utiliser #{@symbol1}"
                puts ""
            end
        end

        def play_game
            count = 0
            if @player1.goes_first? == true
                while count < 8 
                    check_board(@player1.play, @player1.symbol)
                    announce_winner(is_winner?(@player1))
                    count += 1

                    check_board(@player2.play, @player2.symbol) 
                    announce_winner(is_winner?(@player2))
                    count += 1
                end
            else
                while count < 8
                    check_board(@player2.play, @player2.symbol)
                    announce_winner(is_winner?(@player2))
                    count += 1

                    check_board(@player1.play, @player1.symbol)
                    announce_winner(is_winner?(@player1))
                    count += 1
                end
            end
            end_game
        end
#l'affichage du tableau est un peu reparti, on a initié les array
        def display_board(array)
            puts ""
            print " #{array[0][0]} | #{array[0][1]} | #{array[0][2]} \n"
            puts "-----------"
            print " #{array[1][0]} | #{array[1][1]} | #{array[1][2]} \n"
            puts "-----------"
            print " #{array[2][0]} | #{array[2][1]} | #{array[2][2]} \n" 
            puts ""
        end
#ce code ci va vérifier les mouvements et les symbols effectué pendant le jeux
        def check_board(move, symbol)
            @move = move.to_i
            @symbol = symbol

            @winning.each do |array| 
                array.map! do |num| 
                    if num.is_a?(String)
                        num
                    elsif(@move == num)
                        @symbol
                    elsif @move != num && num.is_a?(Integer)
                        num         
                    end
                end
            end
            display_board(@winning)
            puts ""
        end
#ici il va vérifier quel joueur a gagné
        def is_winner?(player)

            @winning.any? do |line|
                line.all? {|position| position == player.symbol}
            end
        end
#et la il va annoncé le joeur gagnant
        def announce_winner(x)
            @x = x

            if @x == true
                puts "#{@name}Tu a gagné, félicitations!!!!! "
                display_board(@winning)
                exit
            else
                return
            end
        end
#sinon match nul
        def end_game
            puts "MATCH NUL"
            exit
        end
    end
#ici le joeur est initié par rapport aux nom qu'on à getchomper
    class Player
        attr_accessor :name, :symbol

        def initialize(name)
            @name = name
        end
#le jeux se fera à tour de role bien sur donc voila le code qui recupère les chiffres qu'on à tapez au cours du jeu
        def play
            puts "#{@name}, A vous de jouer #{self.symbol}."
            puts "Insérez le chiffre correspondant dans la case que vous voulez."
            input = gets.chomp
            puts "#{@name}, tu a choisis le #{input}"
            puts ""
            return input
        end

        def goes_first?
            if self.symbol == "X"
                return true
            else
                return false    
            end
        end
    end
end

#ce commande là sert à appelez le jeux
TicTacToe.new.go