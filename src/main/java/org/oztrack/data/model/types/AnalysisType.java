package org.oztrack.data.model.types;

import java.util.Arrays;
import java.util.List;

public enum AnalysisType {
    MCP(
        "Minimum Convex Polygon",
        Arrays.asList(
            new AnalysisParameterType("percent", "Percent", "double", "%", "100", false, null)
        )
    ),
    KUD(
        "Kernel Utilization Distribution",
        Arrays.asList(
            new AnalysisParameterType("percent", "Percent", "double", "%", "95", false, null),
            new AnalysisParameterType("hEstimator", "h estimator", "string", null, "href", false, Arrays.asList(
                new AnalysisParameterOption("href", "Ad hoc method (href)"),
                new AnalysisParameterOption("LSCV", "Least-square cross validation (LSCV)"),
                new AnalysisParameterOption(null, "None (enter h value) [advanced]")
            )),
            new AnalysisParameterType("hValue", "h value", "double", null, null, true, null),
            new AnalysisParameterType("gridSize", "Grid size", "double", "m", "50", true, null),
            new AnalysisParameterType("extent", "Extent", "double", null, "1", true, null)
        )
    ),
    KBB(
        "Kernel Brownian Bridge",
        Arrays.asList(
            new AnalysisParameterType("percent", "Percent", "double", "%", "95", false, null),
            new AnalysisParameterType("sig1", "sig1", "double", null, null, false, null),
            new AnalysisParameterType("sig2", "sig2", "double", null, null, false, null),
            new AnalysisParameterType("gridSize", "Grid size", "double", "m", "50", true, null),
            new AnalysisParameterType("extent", "Extent", "double", null, "1", true, null)
        )
    ),
    AHULL(
        "Alpha Hull",
        Arrays.asList(
            new AnalysisParameterType("alpha", "Alpha", "double", null, "100", false, null)
        )
    ),
    LOCOH(
        "Local Convex Hull",
        Arrays.asList(
            new AnalysisParameterType("percent", "Percent", "double", "%", "95", false, null),
            new AnalysisParameterType("k", "Neighbours", "double", null, "30", false, null),
            new AnalysisParameterType("r", "Radius", "double", "m", null, false, null)
        )
    ),
    HEATMAP_POINT(
        "Heat Map (Point Intensity)",
        buildHeatmapParameterTypes()
    ),
    HEATMAP_LINE(
        "Heat Map (Line Intensity)",
        buildHeatmapParameterTypes()
    );

    private final String displayName;
    private final List<AnalysisParameterType> parameterTypes;

    private AnalysisType(final String display, List<AnalysisParameterType> parameterTypes) {
        this.displayName = display;
        this.parameterTypes = parameterTypes;
    }

    public String getDisplayName() {
        return this.displayName;
    }

    public List<AnalysisParameterType> getParameterTypes() {
        return parameterTypes;
    }

    public AnalysisParameterType getParameterType(String identifier) {
        for (AnalysisParameterType parameterType : parameterTypes) {
            if (parameterType.getIdentifier().equals(identifier)) {
                return parameterType;
            }
        }
        return null;
    }

    private static List<AnalysisParameterType> buildHeatmapParameterTypes() {
        return Arrays.asList(
            new AnalysisParameterType("showAbsence", "Show absence", "boolean", null, "false", false, null),
            new AnalysisParameterType("gridSize", "Grid size", "double", "m", "100", false, null),
            new AnalysisParameterType("colours", "Colours", "string", null, "YlOrRed", false, Arrays.asList(
                new AnalysisParameterOption("YlOrRd", "Yellow-Orange-Red"),
                new AnalysisParameterOption("YlOrBr", "Yellow-Orange-Brown"),
                new AnalysisParameterOption("YlGnBu", "Yellow-Green-Blue"),
                new AnalysisParameterOption("YlGn", "Yellow-Green"),
                new AnalysisParameterOption("Reds", "Red"),
                new AnalysisParameterOption("RdPu", "Red-Purple"),
                new AnalysisParameterOption("Purples", "Purple"),
                new AnalysisParameterOption("PuRd", "Purple-Red"),
                new AnalysisParameterOption("PuBuGn", "Purple-Blue-Green"),
                new AnalysisParameterOption("PuBu", "Purple-Blue"),
                new AnalysisParameterOption("OrRd", "Orange-Red"),
                new AnalysisParameterOption("Oranges", "Orange"),
                new AnalysisParameterOption("Greys", "Grey"),
                new AnalysisParameterOption("Greens", "Green"),
                new AnalysisParameterOption("GnBu", "Green-Blue"),
                new AnalysisParameterOption("BuPu", "Blue-Purple"),
                new AnalysisParameterOption("BuGn", "Blue-Green"),
                new AnalysisParameterOption("Blues", "Blue")
            ))
        );
    }
}