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
      %initializing the default values for free places,assuming the whole
      %row or file is empty.
      upper_highest=8;
      upper_color='None';                           %assuming that no piece is there in the last possible khana(and it is possible to move there)
      upper_piece='None';                           %assuming that no piece is there in the last possible khana
      lower_lowest=1;
      lower_color='None';                           %assuming that no piece is there in the last possible khana
      lower_piece='None';                           %assuming that no piece is there in the last possible khana
      left_lowest=1;
      left_color='None';                            %assuming that no piece is there in the last possible khana
      left_piece='None';                            %assuming that no piece is there in the last possible khana
      right_highest=8;
      right_color='None';                           %assuming that no piece is there in the last possible khana
      right_piece='None';                           %assuming that no piece is there in the last possible khana
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
    if strcmp(current_status(i).status,'Alive')&&(and(strcmp(current_status(i).color,Color),strcmp(current_status(i).piece,'Bishop')))
        % initializing the default value of free space in digonal of
        % movement of bishop ,assuming the whole digonal is empty.
        
        % for firstQuadrant (relative to Bishop)
        first_closest_file_diff=8-current_status(i).file;
        first_closest_rank_diff=8-current_status(i).rank;
        first_color='None';                     %assuming that no piece is there in the last possible khana
        first_piece='None';                     %assuming that no piece is there in the last possible khana
        if first_closest_file_diff<first_closest_rank_diff
            first_closest_file=8;
            first_closest_rank=current_status(i).rank+first_closest_file_diff;
        else
            first_closest_rank=8;
            first_closest_file=current_status(i).file+first_closest_rank_diff;
        end
        
        %for second Quadrant(relative to Bishop)
        second_closest_file_diff=current_status(i).file-1;
        second_closest_rank_diff=8-current_status(i).rank;
        second_color='None';                        %assuming that no piece is there in the last possible khana
        second_piece='None';                        %assuming that no piece is there in the last possible khana
        if second_closest_file_diff<second_closest_rank_diff
            second_closest_file=1;
            second_closest_rank=current_status(i).rank+second_closest_file_diff;
        else
            second_closest_rank=8;
            second_closest_file=current_status(i).file-second_closest_rank_diff;
        end
        
        %for third Quadrant(relative to Bishop)
        third_closest_file_diff=current_status(i).file-1;
        third_closest_rank_diff=current_status(i).rank-1;
        third_color='None';                 %assuming that no piece is there in the last possible khana
        third_piece='None';                 %assuming that no piece is there in the last possible khana
        if third_closest_file_diff<third_closest-rank_diff
            third_closest_file=1;
            third_closest_rank=current_status(i).rank-third_closest_file_diff;
        else
            third_closest_rank=1;
            third_closest_file=current_status(i).file-third_closest_rank_diff;
        end
        
        % for fourth quadrant(relative to Bishop)
        fourth_closest_file_diff=8-current_status(i).file;
        fourth_closest_rank_diff=current_status(i).rank-1;
        if fourth_closest_file_diff<fourth_closest_rank_diff
            fourth_closest_file=8;
            fourth_closest_rank=current_status(i).rank-fourth_closest_file_diff;
        else
            fourth_closest_rank=1;
            fourth_closest_file=current_status(i).file+fourth_closest_rank_diff;
        end
        
        for j=1:m,
            if j~=i
               file_diff=current_status(j).file-current_status(i).file;
               rank_diff=current_status(j).rank-current_status(i).rank;
               % checking if the (examining) piece is in the first quadrant
               % digonal.
               if and(and(file_diff>0,rank_diff>0),(file_diff./rank_diff)==1);
                   if current_status(j).file<=first_closest_file
                       first_closest_file=current_status(j).file;
                       first_closest_rank=current_status(j).rank;
                       first_color=current_status(j).color;
                       first_piece=current_status(j).piece;
                   end
               
               % checking on second quadrant digonal
               elseif and(and(file_diff<0,rank_diff>0),(file_diff./rank_diff)==-1);
                   if current_status(j).file>=second_closest_file
                       second_closest_file=current_status(j).file;
                       second_closest_rank=current_status(j).rank;
                       second_cloor=current_status(j).color;
                       second_piece=current_status(j).piece;
                   end
                   
               % checking on third quadrant digonal
               elseif and(and(file_diff<0,rank_diff<0),(file_diff./rank_diff)==1);
                   if current_status(j).file>=third_closest_file
                       third_closest_file=current_status(j).file;
                       third_closest_rank=current_status(j).rank;
                       third_color=current_status(j).color;
                       third_piece=current_status(j).piece;
                   end
               % checking in fourth quadrant digonal    
               elseif and(and(file_diff>0,rank_diff<0),(file_diff./rank_diff)==-1);
                   if current_status(j).file<=fourth_closest_file
                       fourth_closest_file=current_status(j).file;
                       fourth_closest_rank=current_status(j).rank;
                       fourth_color=current_status(j).color;
                       fourth_piece=current_status(j).piece;
                   end
               end
            end
        end
        try
            legal_moves=[legal_moves;create_legal_move_bishop(Color,current_status(i),first_closest_file,first_closest_rank,first_color,first_piece,second_closest_file,second_closest_rank,second_color,second_piece,third_closest_file,third_closest_rank,third_color,third_piece,fourth_closest_file,fourth_closest_rank,fourth_color,fourth_piece)];
        catch
             legal_moves=create_legal_move_bishop(Color,current_status(i),first_closest_file,first_closest_rank,first_color,first_piece,second_closest_file,second_closest_rank,second_color,second_piece,third_closest_file,third_closest_rank,third_color,third_piece,fourth_closest_file,fourth_closest_rank,fourth_color,fourth_piece);
        end
    end
    
    %%
   
end
end