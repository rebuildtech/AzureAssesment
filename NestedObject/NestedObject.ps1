#Creating a Function to get the nested Object Value

function Get-NestedObjectValue {
    [CmdletBinding()]
      param(
        [Parameter(Mandatory=$true)]
        [Hashtable]$Object,
    
        [Parameter(Mandatory=$true)]
        [String]$Key
      )
    
      #Splitting the key value with '/'
      $keys = $Key -split '/'

      #Creating a new variable to run the loop for the keys and its hashtable object
      $value = $Object
    
      #Run the loop for each splitted key value and get the nested object value 
      foreach ($k in $keys) {
        $value = $value[$k]
      }
    
      #Return the Output of the nested Object Value
      return $value
    }
    
    
    
    #Below is the code to run for testing

#Input Parameter values that needs to be given to run the function
    $nestedObject = @{
      'a' = @{
        'b' = @{
          'c' = 'd'
        }
      }
    }
    $KeyValue = 'a/b/c'

# The main command to run and get the desired output
    Get-NestedObjectValue -Object $nestedObject -Key $KeyValue