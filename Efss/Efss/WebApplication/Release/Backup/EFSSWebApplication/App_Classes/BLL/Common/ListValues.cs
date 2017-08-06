
namespace APP.Common
{
    public class ListValues
    {
        string _name = string.Empty;

        public string Name
        {
            get
            {
                return _name;
            }
            set
            {
                _name = value;
            }
        }

        string _value = string.Empty;

        public string Value
        {
            get
            {
                return _value;
            }
            set
            {
                _value = value;
            }
        }

        public ListValues(string Name, string Value)
        {
            _name = Name;
            _value = Value;
        }

        public override string ToString()
        {
            return _value;
        }
    }
}