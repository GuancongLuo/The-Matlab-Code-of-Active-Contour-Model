function band = isband( phi, front, width )%�ж��Ƿ�Ϊխ����
% CALCBAND Determine which points are within narrow band
%    CALCBAND( phi, front, width ) Based on the indices of the
%    front points, determine which pixels of phi are within a
%    narrow band of width 'width' of the front points. Return a
%    boolean matrix the same size as phi.
%����һ����phi��С��ͬ�Ķ�ֵ����ֵΪ��ʾ��խ���ڵĵ�
%frontΪ���з���������ֵ


% grab size of phi
[ m, n ] = size( phi );

% precompute width squared to save computations later
widthsq = width^2;

% retrieve indices of and total number of front points
n_front = size( front, 1 );%���ڶ�������Ϊ1ʱ��������������һά�Ĵ�С

% create an boolean matrix whose value at each pixel is 0 or 1
% depending on whether that pixel is a band point or not
band = zeros( m, n );

% for each pixel in phi
for ii = 1 : m;
  for jj = 1 : n;

    % check if it is within 'width' of a front pixel
    closest_dist = inf;%inf��ʾ�������
    %�жϵ�(ii,jj)�Ƿ���խ����
    for k = 1 : n_front;

      dist = sum( ( front( k, : ) - [ ii, jj ] ).^2 );%front(k,:)����(k,:)�������ֵ
      if( dist < widthsq )
	band( ii, jj ) = 1;
	break;
      end;

    end;

  end;
end;
