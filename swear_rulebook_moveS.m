function legal_moves=swear_rulebook_moveS(current_status,Color)
%%  %This function contain the rules of the legality of the moves.
    %This will give  a list of all
    %possible moves by all possible pieces alives of one or both, according
    %to need(for AI vs AI,AI vs Human)
     
    %"status matrix" :- will give the current status of board to help decide
    % which pieces possible moves need to be given out.
    %"Color" :-for what color we need to generate the legal moves.
    
%% Calculating all possible moves for each piece of required color
% files=['a';'b';'c';'d';'e';'f';'g';'h'];
[m,~]=size(current_status);
for i=1:m,
    
    %% Writing rule for Rook and taking out the possible moves for Rook
    if strcmp(current_status(i).status,'Alive')&&(and(strcmp(current_status(i).color,Color),strcmp(current_status(i).piece,'Rook')))
      upper_highest=8;
      upper_color='None';
      upper_piece='None';
      lower_lowest=1;
      lower_color='None';
      lower_piece='None';
      left_lowest=1;
      left_color='None';
      left_piece='None';
      right_highest=8;
      right_color='None';
      right_piece='None';
      for j=1:m,
          if (j~=i)
              if (current_status(j).file==current_status(i).file)
                  if (current_status(j).rank>current_status(i).rank)
                      if (current_status(j).rank<=upper_highest)
                          upper_highest=current_status(j).rank;
                          upper_color=current_status(j).color;
                          upper_piece=current_status(j).piece;
                      end
                  elseif (current_status(j).rank<current_status(i).rank)
                      if (current_status(j).rank>=lower_lowest)
                          lower_lowest=current_status(j).rank;
                          lower_color=current_status(j).color;
                          lower_piece=current_status(j).piece;
                      end
                  end  
          elseif (current_status(j).rank==current_status(i).rank)
                  if (current_status(j).file>current_status(i).file)
                      if (current_status(j).file<=right_highest)
                          right_highest=current_status(j).file;
                          right_color=current_status(j).color;
                          right_piece=current_status(j).piece;
                      end
                  elseif (current_status(j).file<current_status(i).file)
                      if (current_status(j).file>=left_lowest)
                          lower_lowest=current_status(j).file;
                          left_color=current_status(j).color;
                          left_piece=current_status(j).piece;
                      end
                  end 
              end
          end
      end
      try
          legal_moves=[legal_moves;create_legal_move_rook(Color,current_status(i),upper_highest,upper_color,upper_piece,lower_lowest,lower_color,lower_piece,left_lowest,left_color,left_piece,right_highest,right_color,right_piece)];
      catch
          legal_moves=create_legal_move_rook(Color,current_status(i),upper_highest,upper_color,upper_piece,lower_lowest,lower_color,lower_piece,left_lowest,left_color,left_piece,right_highest,right_color,right_piece);
      end
    end
    
    %% Taking out all possible moves for Bishop according to rule
    
end
end