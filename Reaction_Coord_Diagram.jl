using Plots 

energies_1 = [0.0 24.3 -48.7]

function construct_plot_segments(energies)

    plotted_energies = []

    for i in 1:length(energies)

        aux_energy = zeros(5)
        aux_dashln = zeros(9)

        for j in 1:5
            aux_energy[j] = energies[i]
        end

        push!(plotted_energies,aux_energy)

        if i != length(energies)
            slope = (energies[i+1] - energies[i]) / 8

            for k in 0:8
                aux_dashln[k+1] = slope*k + energies[i]
            end

            push!(plotted_energies,aux_dashln)

        end


    end

    return plotted_energies
end

function make_plot(energies)

    plot_segments = construct_plot_segments(energies)
    total_segments = length(plot_segments)
    plot_list = []

    counter = 1.0

    for i in 1:total_segments
        if mod(i,2) == 1

            if i == 1
                p1 = plot(counter:counter+4,plot_segments[i],color = :black,legend = false,linestyle = :solid,
                          annotations = (counter+2,plot_segments[i][1]+1.3,"$(plot_segments[i][1])"),annotationfontsize = 10,
                          linewidth = 2)
                counter += 4.0
                push!(plot_list,p1)
            else
                p1 = plot!(counter:counter+4,plot_segments[i],color = :black,legend = false,linestyle = :solid,
                           annotations = (counter+2,plot_segments[i][1]+1.3,"$(plot_segments[i][1])"),annotationfontsize = 10,
                           linewidth = 2)
                counter += 4.0
                push!(plot_list,p1)
            end

        else
            p1 = plot!(counter:counter+8,plot_segments[i],linestyle = :dash,legend = false,color = :black)
            counter += 8.0
            push!(plot_list,p1)
        end
    end

    return plot_list,counter

end

plots_list1, counter1 = make_plot(energies_1)

p1 = plot(plots_list1[1], grid = false, xaxis = true, yguide = "E \n kcal/mol", xguide = "Reaction Coordinate",
          xlims = [0.0, counter1], ylims = [minimum(energies_1)-1,maximum(energies_1)+1],
          xticks = false,
          annotation = (0.0,maximum(energies_1)+1,text('\u27A4',7,:black,rotation=90)))
annotate!(counter1,minimum(energies_1)-1,text('\u27A4',7,:black,rotation=0))

