class Animation
	def initialize(arr)
    @anim_arr = arr
  end
	def animate
		n = @anim_arr.length
		i = 0
	    while i < n
			puts @anim_arr[i]
			sleep(1.0/(i+=1))
			system("clear")
		end
	end
end

animation_arr = [
'


  /\/\/\                           _/**\_ 
 | \  / |                         /      \
 |__\/__|                       /          \ 
 |  /\  |----------------------|     /\     | 
 | /  \ |                      |    /  \    | 
 |/    \|                      |   / __ \   | 
 |\    /|                      |  | (  ) |  | 
 | \  / |                      |  | (__) |  | 
 |__\/__|                 /\   |  |      |  |   /\ 
 |  /\  |                /  \  |  |______|  |  /  \ 
 | /  \ |               |----| |  |      |  | |----| 
 |/    \|---------------|    | | /|   .  |\ | |    | 
 |\    /|               |    | /  |   .  |  \ |    | 
 | \  / |               |    /    |   .  |    \    | 
 |__\/__|               |  /      |   .  |      \  | 
 |  /\  |---------------|/        |   .  |        \| 
 | /  \ |              /     BLR  |   .  |  LOL     \ 
 |/    \|              (__________|______|___________) 
 |/\/\/\|               |____| |--|______|--| |____| 
-------------------------/__\-----/__\/__\-----/__\-----',
'



                                   _/**\_
  /\/\/\                          /      \
 | \  / |                       /          \ 
 |__\/__|                      |     /\     |
 |  /\  |----------------------|    /  \    | 
 | /  \ |                      |   / __ \   | 
 |/    \|                      |  | (  ) |  | 
 |\    /|                      |  | (__) |  | 
 | \  / |                 /\   |  |      |  |   /\
 |__\/__|                /  \  |  |______|  |  /  \
 |  /\  |               |----| |  |      |  | |----|
 | /  \ |               |    | | /|   .  |\ | |    | 
 |/    \|---------------|    | /  |   .  |  \ |    | 
 |\    /|               |    /    |   .  |    \    | 
 | \  / |               |  /      |   .  |      \  | 
 |__\/__|               |/        |   .  |        \| 
 |  /\  |--------------/     BLR  |   .  |  LOL     \
 | /  \ |              (__________|______|___________) 
 |/    \|               |____| |--|______|--| |____|
 |/\/\/\|                /__\     /__\/__\     /__\
------------------------`*%*%`---`*%*%*%*%`---`*%*%`----',
'
                                   _/**\_
                                  /      \
  /\/\/\                        /          \
 | \  / |                      |     /\     |
 |__\/__|                      |    /  \    |
 |  /\  |----------------------|   / __ \   | 
 | /  \ |                      |  | (  ) |  |
 |/    \|                      |  | (__) |  |
 |\    /|                 /\   |  |      |  |   /\
 | \  / |                /  \  |  |______|  |  /  \
 |__\/__|               |----| |  |      |  | |----|
 |  /\  |               |    | | /|   .  |\ | |    |
 | /  \ |               |    | /  |   .  |  \ |    | 
 |/    \|---------------|    /    |   .  |    \    | 
 |\    /|               |  /      |   .  |      \  | 
 | \  / |               |/        |   .  |        \| 
 |__\/__|              /     BLR  |   .  |  LOL     \
 |  /\  |--------------(__________|______|___________)
 | /  \ |               |____| |--|______|--| |____|
 |/    \|                /__\     /__\/__\     /__\
 |/\/\/\|               `%*%*`   `%*%*%*%*`   `%*%*`
-----------------------`*%*%*%`-`*%*%*%*%*%`-`*%*%*%`----',
'
                                   _/**\_
                                  /      \
                                /          \
  /\/\/\                       |     /\     |
 | \  / |                      |    /  \    |
 |__\/__|                      |   / __ \   |
 |  /\  |----------------------|  | (  ) |  |
 | /  \ |                      |  | (__) |  |
 |/    \|                 /\   |  |      |  |   /\
 |\    /|                /  \  |  |______|  |  /  \
 | \  / |               |----| |  |      |  | |----|
 |__\/__|               |    | | /|   .  |\ | |    |
 |  /\  |               |    | /  |   .  |  \ |    |
 | /  \ |               |    /    |   .  |    \    | 
 |/    \|---------------|  /      |   .  |      \  | 
 |\    /|               |/        |   .  |        \| 
 | \  / |              /     BLR  |   .  |  LOL     \
 |__\/__|              (__________|______|___________)
 |  /\  |-------------- |____| |--|______|--| |____|
 | /  \ |                /__\     /__\/__\-----/__\
 |/    \|               `*%*%`   `*%*%*%*%`   `*%*%` 
 |/\/\/\|              `%*%*%*` `%*%*%*%*%*` `%*%*%*`
----------------------`*%*%*%*%`*%*%*%*%*%*%`*%*%*%*%`---',
'
                                  /      \
                                /          \
                               |     /\     |
  /\/\/\                       |    /  \    |
 | \  / |                      |   / __ \   | 
 |__\/__|                      |  | (  ) |  |
 |  /\  |--------------------- |  | (__) |  | 
 | /  \ |                 /\   |  |      |  |   /\
 |/    \|                /  \  |  |______|  |  /  \
 |\    /|               |----| |  |      |  | |----|
 | \  / |               |    | | /|   .  |\ | |    |
 |__\/__|               |    | /  |   .  |  \ |    |
 |  /\  |               |    /    |   .  |    \    |
 | /  \ |               |  /      |   .  |      \  | 
 |/    \|---------------|/        |   .  |        \|
 |\    /|              /     BLR  |   .  |  LOL     \
 | \  / |              (__________|______|___________)
 |__\/__|               |____| |--|______|--| |____| 
 |  /\  |----------------/__\-----/__\/__\-----/__\
 | /  \ |               `%*%*`   `%*%*%*%*`   `%*%*`
 |/    \|              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |/\/\/\|             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
------------------------%*%*%*---%*%*%*%*%*---%*%*%*-----',
'
                                /          \
                               |     /\     |
                               |    /  \    |
  /\/\/\                       |   / __ \   |
 | \  / |                      |  | (  ) |  | 
 |__\/__|                      |  | (__) |  |
 |  /\  |---------------- /\   |  |      |  |   /\
 | /  \ |                /  \  |  |______|  |  /  \
 |/    \|               |----| |  |      |  | |----|
 |\    /|               |    | | /|   .  |\ | |    |
 | \  / |               |    | /  |   .  |  \ |    |
 |__\/__|               |    /    |   .  |    \    |
 |  /\  |               |  /      |   .  |      \  |
 | /  \ |               |/        |   .  |        \|
 |/    \|--------------/     BLR  |   .  |  LOL     \ 
 |\    /|              (__________|______|___________) 
 | \  / |               |____| |--|______|--| |____| 
 |__\/__|                /__\     /__\/__\     /__\
 |  /\  |---------------`*%*%`---`*%*%*%*%`---`*%*%` 
 | /  \ |              `%*%*%*` `%*%*%*%*%*` `%*%*%*` 
 |/    \|             `*%*%*%*%`*%*%*%*%*%*%`*%*%*%*%` 
 |/\/\/\|               %*%*%*   %*%*%*%*%*   %*%*%*
-------------------------*%*%-----*%*%*%*%-----*%*%------',
'
                               |     /\     |
                               |    /  \    |
                               |   / __ \   |
  /\/\/\                       |  | (  ) |  |
 | \  / |                      |  | (__) |  |
 |__\/__|                 /\   |  |      |  |   /\
 |  /\  |----------------/  \  |  |______|  |  /  \
 | /  \ |               |----| |  |      |  | |----|
 |/    \|               |    | | /|   .  |\ | |    |
 |\    /|               |    | /  |   .  |  \ |    |
 | \  / |               |    /    |   .  |    \    |
 |__\/__|               |  /      |   .  |      \  |
 |  /\  |               |/        |   .  |        \|
 | /  \ |              /     BLR  |   .  |  LOL     \ 
 |/    \|--------------(__________|______|___________) 
 |\    /|               |____| |--|______|--| |____|
 | \  / |                /__\     /__\/__\     /__\
 |__\/__|               `%*%*`   `%*%*%*%*`   `%*%*` 
 |  /\  |--------------`*%*%*%`-`*%*%*%*%*%`-`*%*%*%`
 | /  \ |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |/    \|               *%*%*%   *%*%*%*%*%   *%*%*% 
 |/\/\/\|                %*%*     %*%*|%*%*    %*%*
--------------------------*%-------*%---*%------*%-------',
'
                               |    /  \    |
                               |   / __ \   |
                               |  | (  ) |  |
  /\/\/\                       |  | (__) |  |
 | \  / |                 /\   |  |      |  |   /\
 |__\/__|                /  \  |  |______|  |  /  \
 |  /\  |---------------|----| |  |      |  | |----|
 | /  \ |               |    | | /|   .  |\ | |    |
 |/    \|               |    | /  |   .  |  \ |    |
 |\    /|               |    /    |   .  |    \    |
 | \  / |               |  /      |   .  |      \  |
 |__\/__|               |/        |   .  |        \|
 |  /\  |              /     BLR  |   .  |  LOL     \
 | /  \ |              (__________|______|___________)
 |/    \|---------------|____| |--|______|--| |____|
 |\    /|                /__\     /__\/__\     /__\
 | \  / |               `%*%*`   `%*%*%*%*`   `%*%*`
 |__\/__|              `*%*%*%` `*%*%*%*%*%` `*%*%*%` 
 |  /\  |-------------`%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 | /  \ |               *%*%*%   *%*%*%*%*%   *%*%*% 
 |/    \|                %*%*     %*%*|%*%*    %*%*
 |/\/\/\|                 *%       *% | *%      *%
---------------------------------------------------------',
'
                               |   / __ \   |
                               |  | (  ) |  |
                               |  | (__) |  |
  /\/\/\                  /\   |  |      |  |   /\
 | \  / |                /  \  |  |______|  |  /  \
 |__\/__|               |----| |  |      |  | |----|
 |  /\  |---------------|    | | /|   .  |\ | |    |
 | /  \ |               |    | /  |   .  |  \ |    |
 |/    \|               |    /    |   .  |    \    |
 |\    /|               |  /      |   .  |      \  |
 | \  / |               |/        |   .  |        \|
 |__\/__|              /     BLR  |   .  |  LOL     \
 |  /\  |              (__________|______|___________)
 | /  \ |               |____| |--|______|--| |____| 
 |/    \|----------------/__\-----/__\/__\-----/__\
 |\    /|               `%*%*`   `%*%*%*%*`   `%*%*`
 | \  / |              `*%*%*%` `*%*%*%*%*%` `*%*%*%` 
 |__\/__|             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |  /\  |---------------*%*%*%---*%*%*%*%*%---*%*%*%
 | /  \ |                %*%*     %*%*|%*%*    %*%*
 |/    \|                 *%       *% | *%      *%
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                               |  | (  ) |  |
                               |  | (__) |  |
                          /\   |  |      |  |   /\
  /\/\/\                 /  \  |  |______|  |  /  \
 | \  / |               |----| |  |      |  | |----|
 |__\/__|               |    | | /|   .  |\ | |    |
 |  /\  |---------------|    | /  |   .  |  \ |    |
 | /  \ |               |    /    |   .  |    \    |
 |/    \|               |  /      |   .  |      \  |
 |\    /|               |/        |   .  |        \|
 | \  / |              /     BLR  |   .  |  LOL     \
 |__\/__|              (__________|______|___________)
 |  /\  |               |____| |--|______|--| |____|
 | /  \ |                /__\     /__\/__\     /__\
 |/    \|---------------`%*%*`---`%*%*%*%*`---`%*%*`
 |\    /|              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 | \  / |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |__\/__|               *%*%*%   *%*%*%*%*%   *%*%*%
 |  /\  |----------------%*%*-----%*%*-%*%*----%*%*
 | /  \ |                 *%       *% | *%      *%
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                               |  | (__) |  |
                          /\   |  |      |  |   /\
                         /  \  |  |______|  |  /  \
  /\/\/\                |----| |  |      |  | |----|
 | \  / |               |    | | /|   .  |\ | |    |
 |__\/__|               |    | /  |   .  |  \ |    |
 |  /\  |---------------|    /    |   .  |    \    |
 | /  \ |               |  /      |   .  |      \  |
 |/    \|               |/        |   .  |        \|
 |\    /|              /     BLR  |   .  |  LOL     \
 | \  / |              (__________|______|___________)
 |__\/__|               |____| |--|______|--| |____|
 |  /\  |                /__\     /__\/__\     /__\
 | /  \ |               `%*%*`   `%*%*%*%*`   `%*%*` 
 |/    \|--------------`*%*%*%`-`*%*%*%*%*%`-`*%*%*%`
 |\    /|             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 | \  / |               *%*%*%   *%*%*%*%*%   *%*%*%
 |__\/__|                %*%*     %*%* %*%*    %*%*
 |  /\  |-----------------*%-------*%-|-*%------*%
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                          /\   |  |      |  |   /\
                         /  \  |  |______|  |  /  \
                        |----| |  |      |  | |----|
  /\/\/\                |    | | /|   .  |\ | |    |
 | \  / |               |    | /  |   .  |  \ |    |
 |__\/__|               |    /    |   .  |    \    |
 |  /\  |---------------|  /      |   .  |      \  |
 | /  \ |               |/        |   .  |        \|
 |/    \|              /     BLR  |   .  |  LOL     \
 |\    /|              (__________|______|___________)
 | \  / |               |____| |--|______|--| |____|
 |__\/__|                /__\     /__\/__\     /__\
 |  /\  |               `%*%*`   `%*%*%*%*`   `%*%*`
 | /  \ |              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |/    \|-------------`%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |\    /|               *%*%*%   *%*%*%*%*%   *%*%*%
 | \  / |                %*%*     %*%*|%*%*    %*%*
 |__\/__|                 *%       *% | *%      *%
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                         /  \  |  |______|  |  /  \
                        |----| |  |      |  | |----|
                        |    | | /|   .  |\ | |    |
  /\/\/\                |    | /  |   .  |  \ |    |
 | \  / |               |    /    |   .  |    \    |
 |__\/__|               |  /      |   .  |      \  |
 |  /\  |---------------|/        |   .  |        \|
 | /  \ |              /     BLR  |   .  |  LOL     \
 |/    \|              (__________|______|___________)
 |\    /|               |____| |--|______|--| |____|
 | \  / |                /__\     /__\/__\     /__\
 |__\/__|               `%*%*`   `%*%*%*%*`   `%*%*`
 |  /\  |              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 | /  \ |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |/    \|---------------*%*%*%---*%*%*%*%*%---*%*%*%
 |\    /|                %*%*     %*%* %*%*    %*%* 
 | \  / |                 *%       *% | *%      *%
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |----| |  |      |  | |----|
                        |    | | /|   .  |\ | |    |
                        |    | /  |   .  |  \ |    |
  /\/\/\                |    /    |   .  |    \    |
 | \  / |               |  /      |   .  |      \  |
 |__\/__|               |/        |   .  |        \|
 |  /\  |--------------/     BLR  |   .  |  LOL     \
 | /  \ |              (__________|______|___________)
 |/    \|               |____| |--|______|--| |____|
 |\    /|                /__\     /__\/__\     /__\
 | \  / |               `%*%*`   `%*%*%*%*`   `%*%*`
 |__\/__|              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |  /\  |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 | /  \ |               *%*%*%   *%*%*%*%*%   *%*%*% 
 |/    \|----------------%*%*-----%*%*|%*%*----%*%*
 |\    /|                 *%       *% | *%      *%
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |    | | /|   .  |\ | |    |
                        |    | /  |   .  |  \ |    |
                        |    /    |   .  |    \    |
  /\/\/\                |  /      |   .  |      \  |
 | \  / |               |/        |   .  |        \|
 |__\/__|              /     BLR  |   .  |  LOL     \
 |  /\  |--------------(__________|______|___________)
 | /  \ |               |____| |--|______|--| |____|
 |/    \|                /__\     /__\/__\     /__\
 |\    /|               `%*%*`   `%*%*%*%*`   `%*%*`
 | \  / |              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |__\/__|             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |  /\  |               *%*%*%   *%*%*%*%*%   *%*%*% 
 | /  \ |                %*%*     %*%* %*%*    %*%*
 |/    \|-----------------*%-------*%-|-*%------*%
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |    | /  |   .  |  \ |    |
                        |    /    |   .  |    \    |
                        |  /      |   .  |      \  |
  /\/\/\                |/        |   .  |        \|
 | \  / |              /     BLR  |   .  |  LOL     \
 |__\/__|              (__________|______|___________)
 |  /\  |---------------|____| |--|______|--| |____|
 | /  \ |                /__\     /__\/__\     /__\
 |/    \|               `%*%*`   `%*%*%*%*`   `%*%*`
 |\    /|              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 | \  / |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |__\/__|               *%*%*%   *%*%*%*%*%   *%*%*%
 |  /\  |                %*%*     %*%* %*%*    %*%*
 | /  \ |                 *%       *% | *%      *%
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |    /    |   .  |    \    |
                        |  /      |   .  |      \  |
                        |/        |   .  |        \|
  /\/\/\               /     BLR  |   .  |  LOL     \
 | \  / |              (__________|______|___________)
 |__\/__|               |____| |--|______|--| |____|
 |  /\  |--------------- /__\-----/__\/__\-----/__\
 | /  \ |               `%*%*`   `%*%*%*%*`   `%*%*`
 |/    \|              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |\    /|             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 | \  / |               *%*%*%   *%*%*%*%*%   *%*%*%
 |__\/__|                %*%*     %*%* %*%*    %*%*
 |  /\  |                 *%       *% | *%      *%
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |  /      |   .  |      \  |
                        |/        |   .  |        \|
                       /     BLR  |   .  |  LOL     \
  /\/\/\               (__________|______|___________)
 | \  / |               |____| |--|______|--| |____|
 |__\/__|                /__\     /__\/__\     /__\
 |  /\  |---------------`%*%*`---`%*%*%*%*`---`%*%*` 
 | /  \ |              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |/    \|             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |\    /|               *%*%*%   *%*%*%*%*%   *%*%*%
 | \  / |                %*%*     %*%* %*%*    %*%*
 |__\/__|                 *%       *% | *%      *%
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |/        |   .  |        \|
                       /     BLR  |   .  |  LOL     \
                       (__________|______|___________)
  /\/\/\                |____| |--|______|--| |____|
 | \  / |                /__\     /__\/__\     /__\
 |__\/__|               `%*%*`   `%*%*%*%*`   `%*%*`
 |  /\  |--------------`*%*%*%`-`*%*%*%*%*%`-`*%*%*%` 
 | /  \ |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*` 
 |/    \|               *%*%*%   *%*%*%*%*%   *%*%*%
 |\    /|                %*%*     %*%* %*%*    %*%*
 | \  / |                 *%       *% | *%      *%
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |/        |   .  |        \|
                       /     BLR  |   .  |  LOL     \
                       (__________|______|___________)
  /\/\/\                |____| |--|______|--| |____|
 | \  / |                /__\     /__\/__\     /__\
 |__\/__|               `%*%*`   `%*%*%*%*`   `%*%*`
 |  /\  |--------------`*%*%*%`-`*%*%*%*%*%`-`*%*%*%` 
 | /  \ |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*` 
 |/    \|               *%*%*%   *%*%*%*%*%   *%*%*%
 |\    /|                %*%*     %*%* %*%*    %*%*
 | \  / |                 *%       *% | *%      *%
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                       /     BLR  |   .  |  LOL     \
                       (__________|______|___________)
                        |____| |--|______|--| |____|
  /\/\/\                 /__\     /__\/__\     /__\
 | \  / |               `%*%*`   `%*%*%*%*`   `%*%*`
 |__\/__|              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |  /\  |-------------`%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*` 
 | /  \ |               *%*%*%   *%*%*%*%*%   *%*%*%
 |/    \|                %*%*     %*%* %*%*    %*%*
 |\    /|                 *%       *% | *%      *%
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                       (__________|______|___________)
                        |____| |--|______|--| |____|
                         /__\     /__\/__\     /__\
  /\/\/\                `%*%*`   `%*%*%*%*`   `%*%*`
 | \  / |              `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 |__\/__|             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |  /\  |---------------*%*%*%---*%*%*%*%*%---*%*%*%
 | /  \ |                %*%*     %*%* %*%*    %*%*
 |/    \|                 *%       *% | *%      *%
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |____| |--|______|--| |____|
                         /__\     /__\/__\     /__\
                        `%*%*`   `%*%*%*%*`   `%*%*`
  /\/\/\               `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 | \  / |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |__\/__|               *%*%*%   *%*%*%*%*%   *%*%*%
 |  /\  |----------------%*%*-----%*%*|%*%*----%*%*
 | /  \ |                 *%       *% | *%      *% 
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        |____| |--|______|--| |____|
                         /__\     /__\/__\     /__\
                        `%*%*`   `%*%*%*%*`   `%*%*`
  /\/\/\               `*%*%*%` `*%*%*%*%*%` `*%*%*%`
 | \  / |             `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 |__\/__|               *%*%*%   *%*%*%*%*%   *%*%*%
 |  /\  |----------------%*%*-----%*%*|%*%*----%*%*
 | /  \ |                 *%       *% | *%      *% 
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                         /__\     /__\/__\     /__\
                        `%*%*`   `%*%*%*%*`   `%*%*`
                       `*%*%*%` `*%*%*%*%*%` `*%*%*%`
  /\/\/\              `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
 | \  / |               *%*%*%   *%*%*%*%*%   *%*%*%
 |__\/__|                %*%*     %*%* %*%*    %*%*
 |  /\  |-----------------*%-------*%-|-*%-------*%
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        `%*%*`   `%*%*%*%*`   `%*%*`
                       `*%*%*%` `*%*%*%*%*%` `*%*%*%`
                      `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
  /\/\/\                *%*%*%   *%*%*%*%*%   *%*%*%
 | \  / |                %*%*     %*%* %*%*    %*%*
 |__\/__|                 *%       *%   *%      *%
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                       `*%*%*%` `*%*%*%*%*%` `*%*%*%`
                      `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
                        *%*%*%   *%*%*%*%*%   *%*%*%
  /\/\/\                 %*%*     %*%* %*%*    %*%*
 | \  / |                 *%       *%   *%      *%
 |__\/__|
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                      `%*%*%*%*`%*%*%*%*%*%*`%*%*%*%*`
                        *%*%*%   *%*%*%*%*%   *%*%*%
                         %*%*     %*%* %*%*    %*%*
  /\/\/\                  *%       *%   *%      *%
 | \  / |
 |__\/__|
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                        *%*%*%   *%*%*%*%*%   *%*%*%
                         %*%*     %*%* %*%*    %*%*
                          *%       *%   *%      *%
  /\/\/\
 | \  / |
 |__\/__|
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                         %*%*     %*%* %*%*    %*%*
                          *%       *%   *%      *%

  /\/\/\
 | \  / |
 |__\/__|
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------',
'
                          *%       *%   *%      *%


  /\/\/\
 | \  / |
 |__\/__|
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |                  |          |          |
 | /  \ |                  |          |          |
 |/    \|------------------|----------|----------|
 |\    /|                  |          |          |
 | \  / |                  |          |          |
 |__\/__|                  |          |          |
 |  /\  |------------------|----------|----------|
 | /  \ |                  |          |          |
 |/    \|                  |          |          |
 |/\/\/\|                  |          |          |
---------------------------------------------------------']

rocket = Animation.new(animation_arr)
rocket.animate()