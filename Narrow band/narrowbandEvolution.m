function phi=narrowbandEvolution(phi,g,front,band,delta_t,bandIterNum)

for n=1:bandIterNum
    speed = calcspeed( phi, g, front );%����߽���ϵ��ٶ�ֵ
    speed = extendspeedband( speed, front, band );%���߽��ϵ���ٶ�ֵ��չ������խ����
    phi = phi - delta_t .* speed;
end