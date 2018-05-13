function speed = calcspeed( phi, g, front )%������ÿ������ٶȹ��ɵľ��󣬾���Ĵ�С��phi��ͬ
% CALCSPEED Calculate the speed for front points
%    CALCSPEED( phi, front ) Calculates the speed for the points
%    whose coordinates are given in 'front'.


% set epsilon - larger values means curvature should be small
EPSILON = 0.0025;

% grab the number of front points��ȡ�߽��ĸ���
n = size( front, 1 );

% fill speed matrix with zeros at first
speed = zeros( size( phi ) );

% for every front point
for k = 1 : n;

  % grab the point's coordinatesȡ�ñ߽�������
  i = front( k, 1 );%�߽���x����
  j = front( k, 2 );%�߽���y����

  % calculate the forward differences��ǰ���
  Dx_minus = phi( i, j ) - phi( i, j - 1 );
  Dy_minus = phi( i, j ) - phi( i - 1, j );

  % calculate the backward differences�����
  Dx_plus = phi( i, j + 1 ) - phi( i, j );
  Dy_plus = phi( i + 1, j ) - phi( i, j );

  % calculate the central differences�м���
  Dx_central = ( phi( i, j + 1 ) - phi( i, j - 1 ) ) / 2;
  Dy_central = ( phi( i + 1, j ) - phi( i - 1, j ) ) / 2;

  % calculate the advection component using upwind schemes�����򷽷�����ƽ����
  x_advection = max( Dx_minus, 0 )^2 + min( Dx_plus, 0 )^2;
  y_advection = max( Dy_minus, 0 )^2 + min( Dy_plus, 0 )^2;
  F_advection = sqrt( x_advection + y_advection );

  % calculate the curvature���м��ּ�������
  phi_x   = Dx_central;
  phi_y   = Dy_central;
  phi_xx  = ( phi( i, j + 1 ) + phi( i, j - 1 ) - 2 * phi( i, j ) );
  phi_yy  = ( phi( i + 1, j ) + phi( i - 1, j ) - 2 * phi( i, j ) );
  phi_xy1 = ( phi( i + 1, j + 1 ) + phi( i - 1, j - 1 ) ) / 4;
  phi_xy2 = ( phi( i - 1, j + 1 ) + phi( i + 1, j - 1 ) ) / 4;
  phi_xy  = phi_xy1 - phi_xy2;

  K_top = phi_xx * ( phi_y^2 ) - ( 2 * phi_x * phi_y * phi_xy ) + phi_yy * ( phi_x^2 );
  K_bot = ( ( phi_x^2 ) + ( phi_y^2 )+1e-10 )^(3/2);
  K = K_top / K_bot;

  % calculate the remainder force by estimating |grad phi| from
  % sum of squares of central differences
  grad_phi = sqrt( Dx_central^2 + Dy_central^2 );
  F_remainder = K * grad_phi;

  % estimate the final speed term
  %speed( i, j ) = 1 - EPSILON * F_remainder;
  speed( i, j ) = g( i, j ) .* ( F_advection - EPSILON * F_remainder );

end;
