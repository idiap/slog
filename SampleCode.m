% Copyright (c) 2013 Idiap Research Institute, http://www.idiap.ch/
% Written by Majid Yazdani <majid.yazdaani@gmail.com>,
% Majid Yazdani <majid.yazdaani@gmail.com>

% This file is part of SLOG.

% SLOG is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License version 3 as
% published by the Free Software Foundation.

% SLOG is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.

% You should have received a copy of the GNU General Public License
% along with SLOG. If not, see <http://www.gnu.org/licenses/>.

function [  ] = SampleCode(  )
%UNTITLED16 Summary of this function goes here
%   Detailed explanation goes here

addpath('IterativeRanking', 'StructuredLatentSpace', 'LatentSpace', 'multi-objects' , 'Joint', 'Link-based');


%%%%%%%%%%%%%%%% E is index1 index2 val

load './sampleData/Slashdot.txt'
Eslash = Slashdot;
clear Slashdot;


%%%%%%%%%%%%%%  X is features vector
%%%%%%%%%%%%%%  index1 index2 val : index1 is index of the object , index2
%%%%%%%%%%%%%%  is the index of the feature, val is the value of the
%%%%%%%%%%%%%%  feature

load './sampleData/SeerE'
Eseer = SeerE;
clear SeerE;

load './sampleData/SeerX'
Xseer = SeerX;
clear SeerX;

Xseer = sparse(Xseer(:,1), Xseer(:,2), Xseer(:,3), max(max(Eseer)), max(Xseer(:,2)));




%%%%%%%%%%%%%%%   Running some of the functions on the above data sets




%%%%%%%%%%%%%% Linked based :

%tr = makeTransformationMatrix( Eseer, size(Xseer,1));
%T = 10;
%a = 1;

%h=HittingTimeTo(T, a ,tr, size(Xseer,1));

%print('hittingtime from node_2 to a: %e \n', h(2));


%h=HittingTimeFrom(a,T,tr,size(Xseer,1),10000);

%print('hittingtime to node_785 from a: %e with using 10000 samples \n', h(785));

%alpha = 0.9;
%p =PPR(alpha,T, tr, size(Xseer,1), a);
%print('ppr of node_785 from a is %e\n', p(785));
 
% vp = VisitingProbabilityTo(alpha,T, tr, size(Xseer,1),a);
% print('vp from node_2 to a is %e\n', vp(2));
% 
% e = 0.001;
% [vp T] = VPTo(alpha,e, tr, size(Xseer,1),a);
% print('vp from node_2 to a is %e\n', vp(2));
% 
% 
%vp = VisitingProbabilityFrom(alpha,a,T,tr,size(Xseer,1),10000);
%print('vp from a to node_785 is %e\n', vp(785));
%e = 0.5;

%vp = VPFromAcyc(alpha,e, tr, size(Xseer,1),a);
%print('vp from a to node_785 is %e\n', vp(785));

%[vp T]= VPFrom(alpha,tr, size(Xseer,1),e, a);
%print('vp from a to node_785 is %e\n', vp(785));


%[vals inds T] = returnKClosestAcyc(alpha,tr,size(Xseer,1),e,a,10);
%print('closest with a is %e\n', inds(1));

%[vals inds T] = returnKClosest(alpha,tr,size(Xseer,1),e,a,10);
%print('closest with a is %e\n', inds(1));

% 

%%%%%%%%%%%%%% Latent space 

%Xseer = normr(Xseer);
%M = rand(1,size(Xseer,2));
%E = Eseer(:,1:2);
%Iter = 10000;
%[ M ]= DistanceLearningDiag_SGD(Iter, Xseer, E, M, 0.1, 0.1 );
%[ closest  ] = returnKClosest_Diag( Xseer(1,:), Xseer, M, 10);
%print('closest with a is %e\n', closest(2));

% 
% M = rand(size(Xseer,2),size(Xseer,2));
% DistanceLearningFullMatrix_SGD(Iter, Xseer, E, M, 0.1, 0.1 );
% [closest] = returnKClosest_FullMatrix( Xseer(1,:), Xseer, M, 10);
% print('closest with a is %e\n', closest(2));
% 

%A = rand(size(Xseer,2), 10);
%[ A ]= EmbedToLatentSpace_SGD(Iter, Xseer, E, A, 0.1, 0.1);
%[closest] = returnKClosestLatentSpace( Xseer(1,:), Xseer, A, 10);
%print('closest with a is %e\n', closest(2));

% A = rand(size(Xseer,2), 10);
% B = rand(size(Xseer,2), 10);
% 
% [ A B]= EmbedToLatentSpaceDirected_SGD(Iter, Xseer, E, A,B, 0.1, 0.1);
% [closest] = returnKClosestLatentSpace_Directed( Xseer(1,:), Xseer, A,B,
% 10);
% print('closest with a is %e\n', closest(2));

% E = Eslash(:,1:2)+1;
% A = rand(max(max(E(:,1), max(E(:,2)))), 10);
% [ A ]= EmbedToLatentSpace_SGD_WithoutFeatures(Iter, E, A, 0.1, 0.1);
% [ closest  ] = returnKClosestLatentSpace_WithoutFeatures( A(1,:), A, 10);
% 
% print('closest with a is %e\n', closest(2));
% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Joint Similarity

% Xseer = normr(Xseer);
% M1 = rand(1,size(Xseer,2));
% M2 = rand(1,size(Xseer,2));
% 
% M{1}=M1;
% M{2} = M2;
% A =  rand(1,size(Xseer,2));
% 
% E1 = Eseer(:,1:2);
% E{1}=E1;
% E{2}=E1;
% Iter = 10000;
% 
% [ A M ] = AdditiveSim_Diag_SGD( Iter, Xseer, E, A, M, 0.1, 0.1);




% Xseer = normr(Xseer);
% M1 = rand(size(Xseer,2),size(Xseer,2));
% M2 = rand(size(Xseer,2),size(Xseer,2));
% 
% M{1}=M1;
% M{2} = M2;
% A =  rand(size(Xseer,2),size(Xseer,2));
% 
% E1 = Eseer(:,1:2);
% E{1}=E1;
% E{2}=E1;
% Iter = 10000;
% 
% [ A M ] = AdditiveSim_Full_SGD( Iter, Xseer, E, A, M, 0.1, 0.1);
% 
% Xseer = normr(Xseer);
% M1 = rand(size(Xseer,2),10);
% M2 = rand(size(Xseer,2),10);
% 
% M{1}=M1;
% M{2} = M2;
% A =  rand(size(Xseer,2),10);
% 
% E1 = Eseer(:,1:2);
% E{1}=E1;
% E{2}=E1;
% Iter = 10000;

% AdditiveSim_LowRank_SGD( Iter, Xseer, E, A, M, 0.1, 0.1)


% Xseer = normr(Xseer);
% M1 = rand(1,10);
% M2 = rand(1,10);
% 
% M{1}=M1;
% M{2} = M2;
% A =  rand(size(Xseer,2),10);
% 
% E1 = Eseer(:,1:2);
% E{1}=E1;
% E{2}=E1;
% Iter = 10000;
% 
% [ A M ] = SharedLatentSpace_Diag_SGD( Iter, Xseer, E, A, M, 0.1, 0.1)


% Xseer = normr(Xseer);
% M1 = rand(10,10);
% M2 = rand(10,10);
% 
% M{1}=M1;
% M{2} = M2;
% A =  rand(size(Xseer,2),10);
% 
% E1 = Eseer(:,1:2);
% E{1}=E1;
% E{2}=E1;
% Iter = 10000;
% 
% [ A M ] = SharedLatentSpace_Full_SGD( Iter, Xseer, E, A, M, 0.1, 0.1)


%%%%%%%%%%%%%%%%% Iterative Ranking

% 
% Xseer = normr(Xseer);
% M = rand(1,size(Xseer,2));
% E = Eseer(:,1:2);
% Iter = 10000;
% Alocal = rand(size(Xseer,2), 10);
% [ Alocal ]= EmbedToLatentSpace_SGD(Iter, Xseer, E, Alocal, 0.1, 0.1);
% 
% [A  w] = NeighborAwareRanker_LowRank(Iter, Xseer, E, Alocal,[0 0], 0.1,0.1,0.8);
% 
% [ closest] = returnKClosestIterative_LowRank(5, E, size(Xseer,1), 1,Xseer(1,:), Xseer, A,w,Alocal, 10,0.8,0.8); %frac
% closest
% 



%%%%%%%%%%%%%%%% structured latent space
Xseer = normr(Xseer);
M = rand(1,size(Xseer,2));
E = Eseer(:,1:2);
Iter = 1000;
A = rand(size(Xseer,2), 10);
[ A ]= EmbedToLatentSpace_SGD(Iter, Xseer, E, A, 0.1, 0.1);

[ closest ] = StructuredLatentSpace_BeamSearch( Xseer(1,:), A , Xseer,5, 0.75, 1 );

closest



end

