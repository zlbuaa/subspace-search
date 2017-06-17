obj = VideoReader('F://UCF-101//ApplyEyeMakeup//v_ApplyEyeMakeup_g01_c01.avi');%输入视频位置
numFrames = obj.NumberOfFrames;% 帧的总数
 for k = 1 : 164 % 读取前164帧
     frame = read(obj,k);%读取第几帧
     %imshow(frame);%显示帧
      imwrite(frame,strcat('F:\UCF\',num2str(k),'.jpg'),'jpg');% 保存帧
 end