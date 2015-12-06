class Graph
{
  float x;
  float y;
  float border;
  float graphLength;
  float vertPoints;
  float barWidth;
  float vertSmallLineLength;
  float horiSmallLineLength;
  float inc;
  float maxValue;
  float value;
  
  // Goals scored / number of games
  ArrayList<Float> goalsPerGame;
  
  Graph()
  {
    x = 0.0f;
    y = 0.0f;
    border = width / 12.0f;
    graphLength = width - (border * 2.0f);
    vertPoints = graphLength / 10.0f;
    barWidth = graphLength / season.size();
    vertSmallLineLength = height / 100.0f;
    horiSmallLineLength = width / 100.0f;
    inc = 0.0f;
    maxValue = 0.0f;
    value = 0.0f;
    goalsPerGame = new ArrayList<Float>();
    
    calcGoalsPerGame();
  } 
  
  void calcGoalsPerGame()
  {
    for(int i = 0; i < season.size(); i++)
    {
      goalsPerGame.add(season.get(i).scored / season.get(i).played);
    }
  }
  
  void drawBarChart()
  {
    stroke(255);
    
    // Calculate max value from ArrayList to map range
    for(int i = 0; i < season.size(); i++)
    {
      if(goalsPerGame.get(i) > maxValue)
      {
        maxValue = goalsPerGame.get(i);
      }
    }
    
    float vertPointValue = maxValue / 10;
    
    for(int i = 0; i <= season.size(); i++)
    {    
      // Horizontal line
      textSize(width / 50);
      text("Seasons", width / 2, height - (border / 4));
      
      textSize(width / 100.0f);
      line(border, height - border, border + x, height - border);
      line(border + x, (height - border), border + x, (height - border) + vertSmallLineLength);
      
      // Out of bounds error without if() statement
      if(i < season.size())
      {
        // Map Range
        value = map(goalsPerGame.get(i), 0, maxValue, 0, graphLength);
        
        /*
          Extra 3 spacing aligns years properly
          Extra 20 spacing at end drops the years down a bit - looks neater
        */
        fill(255);
        text(round(season.get(i).year), border + x + 3, (height - border) + vertSmallLineLength + 20);
        
        // Draw bars
        fill(random(255), random(255), random(255));
        rect(border + x, (height - border) - value, barWidth, value);
      }
      
      /*
        Increments of y points are sufficiently bigger than increments of x points that to draw the 
        entire vertical line the points need only be drawn half as many times as there are elements in the ArrayList.
      */
      if(i < season.size() / 2)
      {
        String sf = nf(vertPointValue, 1, 2);
        vertPointValue = float(sf);
        
        pushMatrix();
        translate(border / 3, height / 2);
        rotate(-HALF_PI);
        textSize(height / 50);
        text("Goals per Game", 0, 0);
        popMatrix();
        
        // Vertical line
        textSize(width / 100.0f);
        line(border, height - border, border, (height - border) - y);
        line(border - horiSmallLineLength, (height - border) - y, border, (height - border) - y);
        
        fill(255);
        text(Float.toString(vertPointValue * i), border - horiSmallLineLength - 25, (height - border) - y);
      } 
      
      x += barWidth;
      y += vertPoints;
      inc += 0.5;
    }
  }
}
