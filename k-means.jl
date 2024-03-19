using Plots

#分四組
function group(initial_coordinates)
    group_A = []
    group_B = []
    group_C = []
    group_D = []

    for coord in coordinates 
        #用hypot找出兩座標間的直線距離，distance用來記錄每個座標跟給定點的直線距離
        distance = []
        for initial_coord in initial_coordinates
            push!(distance, hypot(coord[1] - initial_coord[1], coord[2] - initial_coord[2]))
        end
        #argmin用來找出陣列中第幾個元素是最小值然後加入對應的組別
        if argmin(distance) == 1
            push!(group_A,coord)

        elseif argmin(distance) == 2
            push!(group_B,coord)

        elseif argmin(distance) == 3
            push!(group_C,coord)

        else argmin(distance) == 4
            push!(group_D,coord)
    
        end
    end
    return group_A , group_B , group_C , group_D
end

#找出每一組中心點的座標
function centre_coord(coordinates)
    x_sum = sum(t -> t[1], coordinates)
    y_sum = sum(t -> t[2], coordinates)

    x_avg = x_sum / length(coordinates)
    y_avg = y_sum / length(coordinates)
    
    avg_coordinate = (x_avg, y_avg)
    
    return avg_coordinate
end

#計算每組座標跟給定點的平均距離
function distance(group)
    coord = centre_coord(group)
    distance = []
    for g in group
        push!(distance,hypot(g[1] - coord[1], g[2] - coord[2]))
    end
    distance = sum(distance)/length(group)
    return distance
end 

#計算四組平均距離的平均值
function avg_distance(groups)
    d = []
    for g in groups
        push!(d,distance(g))
    end
    avg_distance = sum(d)/4
    return avg_distance
end

#使用上方的四種函數來循環找出最小的D值
function Kmeans(initial_coordinates)
    D_bar = [] #儲存D值             
    centre = []#紀錄每次循環的中心點
    #找出第一組中心點
    for g in group(initial_coordinates)
        push!(centre,centre_coord(g))
    end 

    for _ in 1:10
        push!(D_bar,avg_distance(group(centre)))#算出D值

        for g in group(centre)
            push!(centre,centre_coord(g))#找出新的中心點
        end
        centre = centre[5:8] #移除舊的中心點
        
    end
    return D_bar
end
coordinates = [(2, 5), (3, 2), (3, 3), (3, 4), (4, 3),
               (4, 4), (6, 3), (6, 4), (6, 6), (7, 2),
               (7, 5), (7, 6), (7, 7), (8, 6), (8, 7)]

initial_coordinates = [(2, 2), (4, 6), (6, 5), (8, 8)]#初始條件

#畫圖
x_values = 1:length(Kmeans(initial_coordinates))
y_values = Kmeans(initial_coordinates)
plot(x_values, y_values, label="Distance", xlabel="cycle", ylabel="distance")
